folderPath = 'labels';  % Replace with the path to your folder
files = dir(folderPath);  % Get all files and folders in the folder

% Filter out the '.' and '..' (current and parent directory)
files = files(~ismember({files.name}, {'.', '..', '.DS_Store'}));

% Loop to display all file names
for i = 1:length(files)
    if ~files(i).isdir  % Check if it is not a folder
        disp(files(i).name)  % Display file name
    else
        subfiles = dir(files(i));
        
    end
end