function run_kilosort_2_5(in_path,output_path)
  % This function runs kilosort 2.5 given an input folder.
  % the input folder needs to contain the ops file
  % The ops.mat file contains all the analysis parameters
  % The chanMap.mat contains the channel positions

  if ~exist('output_path','var')
     output_path = in_path;
  end
  load(fullfile(in_path,'ops.mat'))
  load(fullfile(in_path,'chanMap.mat'))

  % preprocess data to create temp_wh.dat
  rez = preprocessDataSub(ops);
  rez = datashift2(rez, ops.doCorrection); % last input is for shifting data

  % ORDER OF BATCHES IS NOW RANDOM, controlled by random number generator
  iseed = 1;                 
  rez = learnAndSolve8b(rez, iseed); % main tracking and template matching algorithm

  % OPTIONAL: remove double-counted spikes
  % because individual spikes are assigned to multiple templates
  % See issue 29: https://github.com/MouseLand/Kilosort/issues/29
  % rez = remove_ks2_duplicate_spikes(rez);

  rez = find_merges(rez, 1);       % final merges
  rez = splitAllClusters(rez, 1);  % final splits by SVD
  rez = set_cutoff(rez);           % decide on cutoff
  rez.good = get_good_units(rez);

  fprintf('[KILOSORT 2.5] found %d putative good units of %d', sum(rez.good>0),length(rez.good))
  fprintf('[KILOSORT 2.5] Saving results to %s ',output_path)
  rezToPhy(rez, output_path);
  exit(1);
end
