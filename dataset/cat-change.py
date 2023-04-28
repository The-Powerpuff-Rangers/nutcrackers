import os

# directory containing the txt files
directory = 'TypeC'

# loop through all files in the directory
for filename in os.listdir(directory):
    if filename.endswith('.txt'):
        # create a new file with modified contents
        with open(os.path.join(directory, filename), 'r') as f:
            lines = f.readlines()
            
        with open(os.path.join(directory, f'{filename}'), 'w') as f:
            for line in lines:
                f.write('2' + line[1:])
                print(line)
                
