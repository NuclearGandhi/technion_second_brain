%% Run all Asadi Project 1 verification and figure-generation scripts
close all; clc;

out_dir = fileparts(mfilename('fullpath'));
script_names = { ...
    'verify_asadi_derivations_symbolic.m', ...
    'quadrature_envelope_demo.m', ...
    'asadi_1to2_slowflow.m', ...
    'asadi_2to1_slowflow.m'};

results = repmat(struct('script', '', 'passed', false, 'message', ''), ...
    size(script_names));

fprintf('MCS2 Project 1: Asadi figure generation\n');
fprintf('=======================================\n');
for script_index = 1:numel(script_names)
    script_path = fullfile(out_dir, script_names{script_index});
    fprintf('\nRunning %s\n', script_names{script_index});
    results(script_index) = run_isolated(script_path, ...
        script_names{script_index});
    if results(script_index).passed
        fprintf('PASS: %s\n', script_names{script_index});
    else
        fprintf('FAIL: %s\n  %s\n', script_names{script_index}, ...
            results(script_index).message);
    end
end

failed = ~[results.passed];
fprintf('\nSummary: %d passed, %d failed.\n', nnz(~failed), nnz(failed));
if any(failed)
    failed_names = strjoin({results(failed).script}, ', ');
    error('generateAsadi:scriptFailures', ...
        'Asadi generation failed in: %s', failed_names);
end

function result = run_isolated(script_path, script_name)
%RUN_ISOLATED Keep variables created by run() out of the orchestrator.
    result = struct('script', script_name, 'passed', false, 'message', '');
    try
        run(script_path);
        result.passed = true;
    catch exception
        result.message = getReport(exception, 'basic', ...
            'hyperlinks', 'off');
    end
end
