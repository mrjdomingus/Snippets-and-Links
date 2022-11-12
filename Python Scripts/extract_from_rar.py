# Also see https://pymotw.com/2/zipfile/ for how to use zipfile module
# Also see https://pypi.org/project/unrar/ for where to download unrar

# Dependencies:
#   UNRAR_LIB_PATH: should point to unrar DLL (on Windows)

import logging
import re
import sys
from pathlib import Path

from unrar import rarfile


def extract_and_rename(tmpdir_path, filename, rar, namelist, index, suffix):
    rar.extract(namelist[index], str(tmpdir_path))
    old_path = tmpdir_path.joinpath(namelist[index])
    new_path = old_path.with_name(f"{filename.stem}.{suffix}")
    old_path.rename(new_path)


def main(rardir):
    """Simplifies CoderProg RAR file

        Will keep:
        * any zip files (assuming these contain source code)
        * File(s) with extension pdf XOR epub XOR (in order of preference)

    Arguments:
        rardir {string} -- Path of directory containing RAR files
    """
    logging.basicConfig()
    logger = logging.getLogger()
    logger.setLevel(logging.INFO)

    rardir_path = Path(rardir)
    tmpdir_path = rardir_path.joinpath("tmp")

    if not (tmpdir_path.exists()):
        tmpdir_path.mkdir()
    else:
        # Empty TMPDIR if not empty
        files_to_clean = [f for f in tmpdir_path.iterdir()]
        for f in files_to_clean:
            f.unlink()

    onlyfiles = [f for f in rardir_path.iterdir() if re.search(".rar$", str(f).lower())]

    # Loop thru all RAR files
    for filename in onlyfiles:
        logger.info(f"Processing rar-file: {filename}...")
        rar = rarfile.RarFile(str(filename))
        namelist = rar.namelist()
        zipIndex = -1
        pdfIndex = -1
        epubIndex = -1

        for idx, name in enumerate(namelist):
            if re.search(".zip$", name.lower()):
                zipIndex = idx
                logger.info(f"\t{namelist[zipIndex]}")
            if re.search(".pdf$", name.lower()):
                pdfIndex = idx
                logger.info(f"\t{namelist[pdfIndex]}")
            if re.search(".epub$", name.lower()):
                epubIndex = idx
                logger.info(f"\t{namelist[epubIndex]}")

        # Save and rename eligile files in the zip file
        if zipIndex > -1:
            extract_and_rename(tmpdir_path, filename, rar, namelist, zipIndex, "zip")
        if pdfIndex > -1:
            extract_and_rename(tmpdir_path, filename, rar, namelist, pdfIndex, "pdf")
        # Only extract EPUB if no PDF
        elif epubIndex > -1:
            extract_and_rename(tmpdir_path, filename, rar, namelist, epubIndex, "epub")

    print("Done!")


if __name__ == "__main__":
    if len(sys.argv) != 2:
        print("Usage: extract_from_rar <rar-dir>")
    else:
        main(sys.argv[1])
