function run_kilosort3_0(in_path,output_path)
  % This function runs kilosort 3.0 given an input folder.
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
  rez = datashift2(rez, ops.doCorrection); 

  [rez, st3, tF] = extract_spikes(rez);
  rez = template_learning(rez, tF, st3);
  [rez, st3, tF] = trackAndSort(rez);
  rez = final_clustering(rez, tF, st3);
  rez = find_merges(rez, 1);


  rezToPhy2(rez, output_path);
  exit(1);
end
