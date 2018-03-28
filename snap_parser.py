import sys
import os
import shutil
"""
This script is used to seperate out individual groups of snapshot data with multiple replicates
"""
def group_files(tiff_extracts_dirname):
    """ Copies tiffs into separate directories based on their group number in
    the filename
    """
    tiff_extracts = os.listdir(tiff_extracts_dirname)
    for tiff_extract in tiff_extracts:

        # extracts the group id from the filename and strips any leading 0s
        group_id = tiff_extract[0:tiff_extract.find('x')].lstrip('0')
        tiff_extract = os.path.join(tiff_extracts_dirname, tiff_extract)

        dirname = os.path.abspath(os.path.join(tiff_extracts_dirname, str(group_id)))
        if not os.path.isdir(dirname):
            os.makedirs(dirname)

        shutil.copy(tiff_extract, os.path.join(dirname, os.path.basename(tiff_extract)))

def main():
    """ Calls group_files based on directory supplied via command line
    """
    tiff_extracts_dirname = os.path.abspath(sys.argv[1])
    group_files(tiff_extracts_dirname)

if '__main__':
    main()
