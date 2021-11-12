---
layout : post
title : "SAdam: An Adam variant that converges faster for convex loss functions"
date : 2021-03-29
categories : Projects
---

I undertook this project along with [Narayanan ER](https://github.com/naruarjun) as part of the ML Reproducibility Challenge 2020. Any variation with respect to Adam with a solid mathematical backing deserves a serious look and hence SAdam got our attention, and we decided to reproduce the results shown in the paper. SAdam is an online convex optimizer that enhances the Adam algorithm by utilizing strong convexity of functions wherever possible. Although the motivation behind making these modifications are to improve performance in only convex cases, they prove to be effective even in non-convex cases.


Explain what convexity means 


SAdam follows the general framework of Adam, deploying a faster decaying rate step size controlled by time-variant hyperparameters to exploit strong convexity. Although it must be mentioned that similar ideas have successfully been applied in the past to the frameworks of Adagrad and RMSProp to get the variants called SC-Adagrad and SC-RMSProp {% cite %}. Theoretical analysis of SAdam (available in { % cite % }) show a data-dependent `O(logT)` regret bound for strongly convex functions, which means that it converges faster than AMSgrad and AdamNC in such cases.

We performed all the experiments mentioned in the original paper by the authors to verify their claims. We added a few experiments of our own to verify whether only the best results on some of the datasets were cherry picked in the original paper. Therefore we ended up performing the following tasks: 

- Calculation of Regret for L2 Regularized Logistic Regression on MNIST, CIFAR10, CIFAR100 for our pool of optimizers, to check whether the central claim of better performance on convex problems stands.

- Computing test accuracy and training loss for a 4-layer CNN and ResNet18 on MNIST, CIFAR10, CIFAR100 for our pool of optimizers to check whether SAdam outperforms the existing optimization techniques in the context of deeper network
training as well, which is inherently a non-convex optimization problem.

- Training a Multi-Layer LSTM on the PennTreeBank dataset on the Language Modelling task, to test the performance of SAdam in a context different from the usual vision domains it had hitherto been tested on

It must also be noted that, the authors had implemented the optimizer in **Tensorflow** and in order to make the optimizer more accessible, we rewrote everything in **PyTorch**. Not just SAdam, in order to compare all the optimizers mentioned in the paper, we implemented SC_RMSProp and SC_Adagrad in Pytorch as well. All the correpsonding code can be found in this [repository](https://github.com/naruarjun/SADAM-reproducibility). The steps to install and run the optimizers are given in detail there. In addition, the details of all of the experiments that were carried out, including the optimal hyperparameters for each are provided in the [reproducibility report](https://openreview.net/forum?id=eNj0zqNUkBU) published on the OpenReview Portal.



### Explanation of the code for implementation of SAdam Optimizer

Explain the code for implementation of SAdam.