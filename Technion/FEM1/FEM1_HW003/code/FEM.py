import builtins
from numpy import *
from fractions import Fraction
from math import lcm, gcd
from functools import reduce
import matplotlib.pyplot as plt


class Printer:
    @staticmethod
    def print_matrix(mat, as_fraction=False, frac_limit_denominator=1000):
        print()
        
        mat = atleast_2d(mat)  # ensure matrix shape (e.g. 1D -> (1,n))
        rows, cols = mat.shape
        
        # Special case for vectors to pretty print without middle rows
        is_vector = rows == 1 or cols == 1
        
        formatted_rows = []
        for r in range(rows):
            row_strs = []
            for c in range(cols):
                val = mat[r, c]
                if as_fraction:
                    frac = Fraction(float(val)).limit_denominator(frac_limit_denominator)
                    if frac.denominator == 1:
                        row_strs.append(f"{str(frac.numerator):>8}")
                    else:
                        row_strs.append(f"{str(frac):>8}")
                else:
                    row_strs.append(f"{float(val):8.4f}")
            
            row_str = ' '.join(row_strs)
            
            if is_vector:
                if r == 0:
                    formatted_rows.append(f"⎡ {row_str} ⎤")
                elif r == rows - 1:
                    formatted_rows.append(f"⎣ {row_str} ⎦")
                else:
                    formatted_rows.append(f"⎢ {row_str} ⎥")
            else:
                if r == 0:
                    formatted_rows.append(f"⎡ {row_str} ⎤")
                elif r == rows - 1:
                    formatted_rows.append(f"⎣ {row_str} ⎦")
                else:
                    formatted_rows.append(f"⎢ {row_str} ⎥")
        
        for line in formatted_rows:
            print(line)
        print()

    @staticmethod
    def print_latex(mat, as_fraction=False, frac_limit=1000, float_precision=4, factor_out_common_factor=False):
        mat = atleast_2d(mat)  # ensure matrix shape
        rows, cols = mat.shape

        if as_fraction:
            # Convert to fractions
            fracs = [
                [Fraction(float(mat[i, j])).limit_denominator(frac_limit) for j in range(cols)]
                for i in range(rows)
            ]

            # Find common denominator
            denoms = [f.denominator for row in fracs for f in row]
            common_denom = reduce(lcm, denoms)

            # Scale numerators
            scaled = [
                [f.numerator * (common_denom // f.denominator) for f in row]
                for row in fracs
            ]

            if factor_out_common_factor:
                nums = [val for row in scaled for val in row]
                common_num = reduce(gcd, nums)
            else:
                common_num = 1

            reduced = [
                [val // common_num for val in row]
                for row in scaled
            ]

            # Compose LaTeX fraction
            if common_num == 1 and common_denom == 1:
                factor_str = ""
            else:
                factor_str = f"\\frac{{{common_num}}}{{{common_denom}}}" if common_num != 1 else f"\\frac{{1}}{{{common_denom}}}"

            # Body
            body = "\n".join(
                " & ".join(f"{val}" for val in row) + r" \\"
                for row in reduced
            )

            latex_str = f"{factor_str}\\begin{{bmatrix}}\n{body}\n\\end{{bmatrix}}"

        else:
            # Float output
            body = "\n".join(
                " & ".join(
                    f"{float(mat[i, j]):.{float_precision}f}" for j in range(cols)
                ) + r" \\"
                for i in range(rows)
            )
            latex_str = f"\\begin{{bmatrix}}\n{body}\n\\end{{bmatrix}}"

        print()
        print(latex_str)
        print()


class Matrices:

        def __init__(self):
            pass

        @staticmethod
        def assemble2Matrices(A1, A2):
            s1 = A1.shape[0]
            s2 = A2.shape[0]
            A = zeros((s1 + s2 - 1, s1 + s2 - 1))
            A[:s1, :s1] = A1
            A[s1-1:, s1-1:] += A2
            return A

        @staticmethod
        def assembleMatrices(As):
            A = As[0]
            for i in range(1, len(As)):
                A = Matrices.assemble2Matrices(A, As[i])
            return A
    

class GLIntegration:
    def __init__(self, p):
        self.points, self.weights = self.getPointsAndWeights(p)

    def integrate(self, f, **kargs):
        return self.pintegrate(self.weights, self.points, f, **kargs)
    
    @staticmethod
    def pintegrate(W, P, f, **kargs):
        I = zeros((2, 2))
        for i in range(len(P)):
            I += W[i]*f(P[i], **kargs)

        return I
    
    @staticmethod
    def getPointsAndWeights(p):
        weights = [
            [2],
            [1, 1],
            [5/9, 8/9, 5/9],
            [(18-sqrt(30))/36, (18+sqrt(30))/36, (18+sqrt(30))/36, (18-sqrt(30))/36],
            [(322 - 13 * sqrt(70))/900, (322 + 13 * sqrt(70))/900, 128/225, (322 - 13 * sqrt(70))/900, (322 - 13 * sqrt(70))/900]
        ]

        points = [
            [0], 
            [-1/sqrt(3), 1/sqrt(3)], 
            [-sqrt(3/5), 0, sqrt(3/5)], 
            [-sqrt(3/7 + 2/7 * sqrt(6/5)), -sqrt(3/7 - 2/7 * sqrt(6/5)), sqrt(3/7 - 2/7 * sqrt(6/5)), sqrt(3/7 + 2/7 * sqrt(6/5))],
            [-1/3 * sqrt(5 + 2 * sqrt(10/7)), -1/3 * sqrt(5 - 2 * sqrt(10/7)), 0, 1/3 * sqrt(5 - 2 * sqrt(10/7)), 1/3 * sqrt(5 + 2 * sqrt(10/7))]
        ]
        return [points[p], weights[p]]


class FEM:

    def __init__(self, n, hᵉ, get_x, k, integrator):  # n - No. of elements, hᵉ - the length of an element (a function), p - No. of points for integration, k (a function)
       
        self.n = n
        self.hᵉ = hᵉ # length of a single element
        self.get_x = get_x
        self.k = k
        self.integrator = integrator
        self.calc_K()
        self.calc_M()

    def xᵉ(self, ξ, e):
        return (self.hᵉ(self.n, e)/2)*ξ + ((2*e-1)*self.hᵉ(self.n, e))/2
    
    def Kᵉ(self, k, e):
        return (k(self.get_x(self.n, e)) / self.hᵉ(self.n, e)) * self.integrator.integrate(self.BᵢBⱼ) / 2
    
    def Mᵉ(self, e):
        return self.hᵉ(self.n, e)/2 * self.integrator.integrate(self.ϕᵢᵉϕⱼᵉ)

    def calc_K(self):
        Ks = []
        for e in range(1, self.n+1):
            Ks.append(self.Kᵉ(self.k, e))

        self.K = Matrices.assembleMatrices(Ks)

    def calc_M(self):
        Ms = []
        for e in range(1, self.n+1):
            Ms.append(self.Mᵉ(e))
            
        self.M = Matrices.assembleMatrices(Ms)

    

    def timeStep(self, α, a0, Δt):
        L = (self.M + α*Δt*self.K)
        R = (self.M - (1-α)*Δt*self.K)

        A = (linalg.inv(L) @ R)

        for i in range(A.shape[1]):
            # A[i][0] = 1 if i == 0 else 0
            A[0][i] = 1 if i == 0 else 0
            # A[-(i+1)][A.shape[1]-1] = 1 if i == 0 else 0
            A[A.shape[1]-1][-(i+1)] = 1 if i == 0 else 0

        a1 = A @ a0
        return a1
    
    @staticmethod
    def ϕᵢᵉϕⱼᵉ(ξ):
        return 1/4 * array([[(1-ξ)**2, (1-ξ)*(1+ξ)], [(1-ξ)*(1+ξ), (ξ+1)**2]])
    
    @staticmethod
    def BᵢBⱼ(ξ):  # constant
        return array([[1, -1], [-1, 1]])


def k(x):
    if 0 < x <= 0.2:
        return 1.2
    elif 0.2 < x <= 0.5:
        return 2.3
    elif 0.5 < x <= 0.9:
        return 3.8
    elif 0.9 < x <= 1.5:
        return 2.6
    else:
        raise ValueError(f"{x=} is not in range!")

# Define the material boundaries (same as MATLAB)
material_boundaries = [0, 0.2, 0.5, 0.9, 1.5]

def get_nodes(n):
    """Get node positions for n elements"""
    if n == 4:
        # For 4 elements, use material boundaries directly
        return material_boundaries.copy()
    else:
        # For other cases, could implement subdivision
        raise NotImplementedError(f"Only n=4 is implemented, got n={n}")

def hᵉ(n, e):
    """Get element length for element e"""
    nodes = get_nodes(n)
    return nodes[e] - nodes[e-1]  # e is 1-indexed

def get_x(n, e):
    """Get element center position for element e"""
    nodes = get_nodes(n)
    # Element center is the average of its two nodes
    return (nodes[e-1] + nodes[e]) / 2  # e is 1-indexed
    

def march_2_steps(α, a0, Δt, print_res=False):
    a1 = f.timeStep(α, a0, Δt)
    a2 = f.timeStep(α, a1, Δt)

    if print_res:
        print(f"a1, {α=}, {Δt=}")
        printer.print_matrix(a1)
        printer.print_latex(a1)

        print(f"a2, {α=}, {Δt=}")
        printer.print_matrix(a2)
        printer.print_latex(a2)

printer = Printer()
GL = GLIntegration(2)

n = 4
f = FEM(n, hᵉ, get_x, k, GL)
printer.print_matrix(f.K, as_fraction=True)
# printer.print_latex(f.K, as_fraction=True, factor_out_common_factor=True)
printer.print_matrix(f.M, as_fraction=True)
# printer.print_latex(f.M, as_fraction=True, factor_out_common_factor=True)

Δt = 0.01

a0 = full((f.M.shape[0], 1), 12)
a0[-1, 0] = 3

march_2_steps(0, a0, Δt)
march_2_steps(0.5, a0, Δt)
march_2_steps(1, a0, Δt)

indices = [0, 1, 10, 50, 100, 250, 500]
a_at_indices = [a0]

a1 = f.timeStep(1, a0, Δt)

for i in range(1, indices[-1] + 1):
    a1 = f.timeStep(1, a1, Δt)
    if i in indices:
        a_at_indices.append(a1)

printer.print_matrix(a1)

print(len(a1))
x_positions = arange(len(a1))

colors = [
    "#B22222",
    "#A2142F",
    "#D95319",
    "#EDB120",
    "#A8E6A1",
    "#77AC30",
    "#006400",
    "#40E0D0",
    "#008080",
    "#4DBEEE",
    "#0072BD",
    "#003366",
    "#7E2F8E",
    "#C71585",
    "#FF69B4",
    "#D3D3D3",
    "#A9A9A9",
    "#505050",
    "#FFFFFF",
    "#000000"
]

plt.figure()
for i in range(len(indices)):
    plt.plot(x_positions, a_at_indices[i], marker='.', linestyle='-', color=colors[i+1], label=f'step={indices[i]}')

plt.title('Plot of a in time for alpha = 1, Δt = 0.001')
plt.xlabel('node')
plt.ylabel('value of a')
plt.grid(True)
plt.legend()
plt.show()

# printer.print_matrix(a1)
# printer.print_latex(a1)