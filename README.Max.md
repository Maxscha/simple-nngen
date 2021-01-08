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


### Cleaned Dataset

Run:
```
python3 nngen.py main files/data/train.diff files/data/train.msg files/data/train.projectIds files/data/test.diff files/data/test.projectIds
```

Evaluate:
```
files/scripts/multi-bleu.perl files/data/test.msg < files/data/results/nngen.test.msg         
```
