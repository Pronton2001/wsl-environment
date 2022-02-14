Technique

# Game RS v1:

```python
1. from google.colab import drive # work with drive
   drive.mount('/content/gdrive')

2. dict(zip(A,B)) # create dictionary {x:y} where x in A, y in B

3. DATA_PATH = "/content/gameID/gameID_221.txt"
   with open(DATA_PATH) as f:
        lines = f.readlines()

4. if not out[8].startswith("com.pay.jxm.item"):
    	raise "Exist item not start with 'com.pay.jxm.item'!" #check start of item

5. df = pd.DataFrame(data=list(map(split_line,lines)), \
			columns=columns) # map(func, *iter) -> map object

6. for itemID in set(df.itemID): # set: unique items

7. history = list(map(lambda x: hash_itemID[x],subdf.itemID.tolist())) # Or, history = [hash_itemID[x] for x in subdf.itemID.tolist()]

8. print(*history,sep=' ') # print just values with custom [sep]

9. import more_itertools as mit
   X_idx = np.array(list(mit.windowed(history, n=N, step=1)))[:-1]

10. <list A>.extend(<list B>) = [list A .... List B]

11. model_checkpoint = ModelCheckpoint(WEIGHTS_PATH, \
	monitor='loss', save_best_only=True, save_feq='epoch')

12. idx = np.where(x>0)[0] # find [idx] where x[idx] > 0
```

# Matplotlib

1. 2x2 images

```python
fig = plt.figure(figsize = (10, 6))
for feature in range(len(feature_dict)):
    plt.subplot(2, 2, feature + 1)
    for index, label in label_dict.items():
        plt.hist(X[y == index, feature], label = label,
                 bins = 10, alpha = 0.3)
        plt.xlabel(feature_dict[feature])
```

2. Visualize multi colmns

```python
grid_spec = gridspec.GridSpec(1, 4, width_ratios=[6, 6, 6, 1])

plt.subplot(grid_spec[0])
...
plt.subplot(grid_spec[1])
...
plt.subplot(grid_spec[2])
...
plt.subplot(grid_spec[3])
...
plt.yticks(range(len(unique_labels)), LABEL_NAMES[unique_labels])
```

3. Visualize subplots_adjust

```python
plt.figure(figsize=(10,9))
plt.subplots_adjust(hspace=0.5)
for n in range(30):
  plt.subplot(6,5,n+1)
  plt.imshow(image_batch[n])
  plt.title(predicted_class_names[n])
  plt.axis('off')
_ = plt.suptitle("ImageNet predictions")
```

# Driving scence segmentation

[https://colab.research.google.com/drive/1j_hYml0oMn5d0ol6ijjXrOgJTcZ908gO#scrollTo=Mv9KQHwAKLSV]

1. Basename of the path

```python
os.path.basename(tar_info.name):
# Example
> path = '/home/User/Documents'
> os.path.basename(path)
> Documents
```

2. Extract frozen graph from tar archive (pre-train model)

```python
FROZEN_GRAPH_NAME = 'frozen_inference_graph'
tar_file = tarfile.open(tarball_path)
for tar_info in tar_file.getmembers():
    if self.FROZEN_GRAPH_NAME in os.path.basename(tar_info.name):
        file_handle = tar_file.extractfile(tar_info)
        graph_def = tf.GraphDef.FromString(file_handle.read())
        break
tar_file.close()
```

3. Create dir & download model into that dir

```python
model_dir = tempfile.mkdtemp()
tf.gfile.MakeDirs(model_dir)
download_path = os.path.join(model_dir, _TARBALL_NAME)

# Download file via URL
urllib.request.urlretrieve(_DOWNLOAD_URL_PREFIX + _MODEL_URLS[MODEL_NAME], download_path)
MODEL = DeepLabModel(download_path)
```

4. Show visualization in a streaming fashion.

```python
def run_visualization_video():
    ...
    f = BytesIO()
    plt.savefig(f, format='jpeg')
    IPython.display.display(IPython.display.Image(data=f.getvalue()))
    f.close()
    ...

for i in range(num_frames):
    _, frame = video.read()
    if not _: break
    run_visualization_video(frame, i)
    IPython.display.clear_output(wait=True)
```

5. Load dataset &

```python
def __init__(...):
    self.tar_file = tarfile.open(tarball_path)
    self.tar_info = self.tar_file.getmembers()
def fetch(..., index):
    tar_info = self.tar_info[index + 1] # exclude index 0 which is the parent directory
    file_handle = self.tar_file.extractfile(tar_info)
    gt = np.fromstring(file_handle.read(), np.uint8) # e.g, convert from '1 2' -> array([1,2])
    gt = cv.imdecode(gt, cv.IMREAD_COLOR) # Reads an image from a buffer in memory
    gt = gt[:, :, 0]  # select a single channel from the 3-channel image
    gt[gt==255] = 19  # void class, does not count for accuracy
```

6. Evaluate acc, intersection & union

```python
def evaluate_single(seg_map, ground_truth):
    """Evaluate a single frame with the MODEL loaded."""
    # calculate accuracy on valid area
    acc = np.sum(seg_map[ground_truth!=19]==ground_truth[ground_truth!=19])/
                    np.sum(ground_truth!=19)

    # select valid labels for evaluation
    cm = confusion_matrix(ground_truth[ground_truth!=19], seg_map[ground_truth!=19],
                          labels=np.array([0,1,2,5,6,7,8,9,11,13]))
    intersection = np.diag(cm)
    union = np.sum(cm, 0) + np.sum(cm, 1) - np.diag(cm) # - np.diag(cm): to remove overlapped ones
    return acc, intersection, union

class_iou = np.round(intersection / union, 5)
```

# GANs

1.

```python
def imgrid(imarray, cols=4, pad=1, padval=255, row_major=True):
  """Lays out a [N, H, W, C] image array as a single image grid."""
  pad = int(pad)
  if pad < 0:
    raise ValueError('pad must be non-negative')
  cols = int(cols)
  assert cols >= 1
  N, H, W, C = imarray.shape
  rows = N // cols + int(N % cols != 0)
  batch_pad = rows * cols - N
  assert batch_pad >= 0
  post_pad = [batch_pad, pad, pad, 0]
  pad_arg = [[0, p] for p in post_pad]
  imarray = np.pad(imarray, pad_arg, 'constant', constant_values=padval)
  H += pad
  W += pad
  grid = (imarray
          .reshape(rows, cols, H, W, C)
          .transpose(0, 2, 1, 3, 4)
          .reshape(rows*H, cols*W, C))
  if pad:
    grid = grid[:-pad, :-pad]
  return grid
```

2. function in funtion

```python
def foo():
    import ...
    ds, = load(...)
    def do_sth():
       ...
       return sth

    ds = ds.map(lambda x: ret_val)
    ds = ds.map(do_sth)
    return ds

foo()
```

3. Interleave: Draw nx2 image, used for visualize the input & output

```python
def interleave(*args):
  """Interleaves input arrays of the same shape along the batch axis."""
  if not args:
    raise ValueError('At least one argument is required.')
  a0 = args[0]
  if any(a.shape != a0.shape for a in args):
    raise ValueError('All inputs must have the same shape.')
  if not a0.shape:
    raise ValueError('Inputs must have at least one axis.')
  out = np.transpose(args, [1, 0] + list(range(2, len(a0.shape) + 1))) # ??
  out = out.reshape(-1, *a0.shape[1:])
  return out

inputs_and_recons = interleave(test_images_batch, _out_recons)
print('inputs_and_recons shape:', inputs_and_recons.shape)
imshow(imgrid(image_to_uint8(inputs_and_recons), cols=2))
```

## Nunmpy [https://cs231n.github.io/python-numpy-tutorial/]

1. Empty like array

```python
y = np.empty_like(x)   # Create an empty matrix with the same shape as x
```

2. Broadcast

```python
# Compute outer product of vectors
print(np.reshape(v, (3, 1)) * w)

# Add a vector to each row of a matrix
print(x + v)

# Add a vector to each column of a matrix
print((x.T + w).T)

# Multiply a matrix by a constant:
print(x * 2)
```

3. Reload automatically

```python
# Some more magic so that the notebook will reload external python modules;
# see http://stackoverflow.com/questions/1907993/autoreload-of-modules-in-ipython
%load_ext autoreload
%autoreload 2
```
