import argparse
import os
import shutil
import sys
import time
import progressbar

def chunks(l, n):
    """Yield successive n-sized chunks from l."""
    for i in range(0, len(l), n):
        yield l[i:i + n]


def main():
	directory=sys.argv[1]
	chunk_size=int(sys.argv[2])
	vals=os.listdir(str(directory))
	xys=[]
	for val in vals:
	    xys.append(val.split('xy')[-1].split('c')[0])
	index_list=list(set(xys))
	if '.DS_Store' in index_list:
	    index_list.remove('.DS_Store')
	index_list=sorted(index_list)

	for index in index_list[::chunk_size]:
	    if not os.path.exists(index):
	        os.makedirs(index)
	list_of_files=list(chunks(index_list, chunk_size))

	locs=index_list[::chunk_size]
	num_xys=len(list_of_files)*len(list_of_files[0])
	i=0
	with progressbar.ProgressBar(max_value=num_xys) as bar:

		for j,group in enumerate(list_of_files):
		    for name in group:
		        matching = [s for s in vals if "xy"+name in s]
		        for match in matching:
		            shutil.copy('tiffs/'+match, locs[j]+'/'+match)
		        bar.update(i)
		        i+=1

     

if __name__ == "__main__":
    main()