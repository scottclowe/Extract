Command/function extract in your console
========================================

What’s a good way to extract: .zip, .rar, .bz2, .gz, .tar, .tbz2, .tgz, .Z, .7z, .xz, .exe, .tar.bz2, .tar.gz, .tar.xz files on the Mac or Linux?

The goal is to make `extract` able to extract anything you give it. The command `extract` uses the free unpackers to support many older, obscure formats like this: .zip, .rar, .bz2, .gz, .tar, .tbz2, .tgz, .Z, .7z, .xz, .exe, .tar.bz2, .tar.gz, .tar.xz

If the file is missing an extension, it will try to detect the encoding from the MIME type of the file.


Installation
------------

### Mac OS X

Copy and paste function section of extract.sh into file `~/.bash_profile`.

### Ubuntu / *nix

Copy and paste function section of extract.sh into file `~/.bashrc`.


Usage
-----

Using command `extract`, in a terminal:

        $ extract <archive_filename.extention>
