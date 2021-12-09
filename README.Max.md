## Paper
https://xin-xia.github.io/publication/ase181.pdf

### Original
To replicate original results run:

```
python3 nngen.py main files/data/original/train.26208.diff files/data/original/train.26208.msg  files/data/original/train.26208.repos files/data/original/test.3000.diff files/data/original/test.3000.diff
```


(This will throw an error at one point, and exit, but the needed data is still generated)
and then evaluate

```
files/scripts/multi-bleu.perl files/data/original/test.3000.msg < files/data/results/nngen.test.3000.msg
```
### Cleaned Deduplicated

```
python3 nngen.py main files/data/commitgen_cleaned_deduplicated/train.22112.diff files/data/commitgen_cleaned_deduplicated/train.22112.msg files/data/commitgen_cleaned_deduplicated/train.22112.repos files/data/commitgen_cleaned_deduplicated/test.2239.diff files/data/commitgen_cleaned_deduplicated/test.2239.diff
```


### Cleaned Dataset

Run:
```
python3 nngen.py main files/data/train.diff files/data/train.msg files/data/train.projectIds files/data/test.diff files/data/test.projectIds
```

Evaluate:
```
files/scripts/multi-bleu.perl files/data/test.msg < files/data/results/nngen.test.msg         
```

### New V1

```
python3 nngen.py main files/data/standard_v1/train.260012.diff files/data/standard_v1/train.260012.msg files/data/standard_v1/train.260012.diff files/data/standard_v1/test.55717.diff files/data/standard_v1/test.55717.diff
```