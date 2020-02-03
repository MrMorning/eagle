#!/usr/bin/env python
# coding: utf-8

# In[44]:


import numpy as np
import matplotlib.pyplot as plt
import os
import skimage.io as io
from skimage.transform import rescale, resize, downscale_local_mean


# In[81]:


images = []
for image in os.listdir('.'):
    if(image.split('.')[-1] == 'gif'):
        img = io.imread('./' + image)
        img = resize(img, (587, 48), anti_aliasing=True)
        images.append(img)


# In[ ]:





# In[116]:


def rgb2tf(img):
    img2 = np.zeros(img.shape[:-1])
    for x in range(img.shape[0]):
        for y in range(img.shape[1]):
            if np.any(img[x, y, :] - np.array([1, 1, 1, 0])):
                img2[x, y] = 1
            else:
                img2[x, y] = 0
    return img2


# In[65]:

#
# n = len(images)
# n


# In[66]:


def show(img):
    plt.imshow(img)
    plt.show()


# # In[73]:
#
#
# images[0].shape
#
#
# # In[105]:
#
#
# show(images[0])
#
#
# # In[148]:
#
#
# images[0][335, -1]
#
#
# # In[118]:
#
#
# rgb2tf(images[0])[100, 25]
#
#
# # In[119]:
#
#
# show(rgb2tf(images[0]))
#
#
# # In[92]:
#
#
# images[0][0, 25, :]
#

# In[142]:


def calc_diff(i, j):
    img1 = np.sum(rgb2tf(images[i])[:, 47] > 0)
    img2 = np.sum(rgb2tf(images[j])[:, 0] > 0)
    return abs(img1 - img2)


# In[169]:

show(images[19])
show(images[34])
eps = 0.01
def calc_diff2(i, j):
    iright = np.array([0., 0., 0.])
    for x in range(images[i].shape[0]):
        color = images[i][x, -1, :-1].reshape((3,))
        if abs(color[0] - 1) > eps:
            if np.max(np.abs(color - np.array([0.78823529, 0.79215686, 0.79215686]))) < eps:
                continue
            iright += color
    print(iright)
    jleft = np.array([0., 0., 0.])
    for x in range(images[j].shape[0]):
        color = images[j][x, 0, :-1].reshape((3,))
        if abs(color[0] - 1) > eps:
            if np.max(np.abs(color - np.array([0.78823529, 0.79215686, 0.79215686]))) < eps:
                continue
            jleft += color
    print(jleft)
    return np.mean(np.abs(iright-jleft))
# In[171]:


print(calc_diff2(19, 34))


# # In[127]:
#
#
# ans = [11]
# for i in range(n-1):
#     ansj = -1
#     minval = 1000000000000
#     for j in range(n):
#         if(j == ans[i]):
#             continue
#         else:
#             if(ansj == -1):
#                 minval = calc_diff(ans[i], j)
#                 ansj = j
#             elif(calc_diff(ans[i], j) < minval):
#                 minval = calc_diff(ans[i], j)
#                 ansj = j
#         print('   ' + str(j))
#     ans.append(ansj)
#     print(i)
# ans
#
#
#
# # In[140]:
#
#
# ans = range(n)
#
#
# # In[141]:
#
#
# # ans = [11, 9]
# big_image = np.copy(images[ans[0]])
# for i in range(1, len(ans)):
#     big_image = np.concatenate((big_image, images[ans[i]]), axis = 1)
# show(big_image)
#
#
# # In[ ]:
#
#
#
#
