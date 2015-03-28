
## Traceability link recovery {#tefse2011}

In our first work, @Corley-etal_2011, we investigated automatic recovery of
traceability links from patches attached to bug reports. Previously to this
work, traceability links between an issue report and the methods changed to
resolve that issue could only be extracted by commit messages left behind by
developers in the software repository. Our work enabled for those methods to be
extracted directly from the issue report via the patches attached to the
report. This patch-based recovery approach has also been in recent work by
@Moreno-etal_2014 to extract datasets for bug localization.

To evaluate this work, we compared our automated approach to manually extracted
links. Two of the authors inspected each bug report patch and created extracted
a goldset of changed methods by hand. The tool was employed on the same bug
report patches, and the other authors verified it's results against the
human-extracted goldset.

We found significant differences between the goldsets and the generated sets.
In general, we found that the tool correctly extracted less false positives and
false negatives than manual extraction.

The patch parsing functionality of the tool was extracted into an open source
Python library named *What The Patch!?*[^wtp]. What The Patch!? is a library
for parsing patch files. It's only purpose is to read a patch file and get it
into some usable form by other programs. The library is installed between 5,000
and 10,000 times a month from the Python package index[^wtppypi].

[^wtp]: https://github.com/cscorley/whatthepatch
[^wtppypi]: https://pypi.python.org/pypi/whatthepatch
