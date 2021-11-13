---
layout : post
title : "SAdam: An Adam variant that converges faster for convex loss functions"
date : 2021-03-29
categories : Projects
---

 SAdam {% cite wang2019sadam %} is an online convex optimizer that enhances the Adam algorithm by utilizing strong convexity of functions wherever possible. Although the motivation behind making these modifications are to improve performance in only convex cases, they prove to be effective even in non-convex cases. I undertook this project along with [Narayanan ER](https://github.com/naruarjun) as part of the ML Reproducibility Challenge 2020. Any variation with respect to Adam with a solid mathematical backing deserves a serious look and hence SAdam got our attention, and we decided to reproduce the results shown in the paper.


A mathematical function is called convex if a 2nd order of differentiation is possible, and if the second derivative is never negative. Owing to this, one of the properties of convex functions is that they have a global minimum. This has led to the adoptiion convex loss functions, although for training deep neural networks working with non-convex loss functions become imperative.


SAdam follows the general framework of Adam, deploying a faster decaying rate step size controlled by time-variant hyperparameters to exploit strong convexity. Although it must be mentioned that similar ideas have successfully been applied in the past to the frameworks of Adagrad and RMSProp to get the variants called SC-Adagrad and SC-RMSProp {% cite mukkamala2017variants %}. Theoretical analysis of SAdam show a data-dependent `O(logT)` regret bound for strongly convex functions, which means that it converges faster than AMSgrad and AdamNC in such cases.

We performed all the experiments mentioned in the original paper by the authors to verify their claims. We added a few experiments of our own to verify whether only the best results on some of the datasets were cherry picked in the original paper. Therefore we ended up performing the following tasks: 

- Calculation of Regret for L2 Regularized Logistic Regression on MNIST, CIFAR10, CIFAR100 for our pool of optimizers, to check whether the central claim of better performance on convex problems stands.

- Computing test accuracy and training loss for a 4-layer CNN and ResNet18 on MNIST, CIFAR10, CIFAR100 for our pool of optimizers to check whether SAdam outperforms the existing optimization techniques in the context of deeper network
training as well, which is inherently a non-convex optimization problem.

- Training a Multi-Layer LSTM on the PennTreeBank dataset on the Language Modelling task, to test the performance of SAdam in a context different from the usual vision domains it had hitherto been tested on

It must also be noted that, the authors had implemented the optimizer in **Tensorflow** and in order to make the optimizer more accessible, we rewrote everything in **PyTorch**. Not just SAdam, in order to compare all the optimizers mentioned in the paper, we implemented SC_RMSProp and SC_Adagrad in Pytorch as well. All the correpsonding code can be found in this [repository](https://github.com/naruarjun/SADAM-reproducibility). The steps to install and run the optimizers are given in detail there. In addition, the details of all of the experiments that were carried out, including the optimal hyperparameters for each are provided in the [reproducibility report](https://openreview.net/forum?id=eNj0zqNUkBU) published on the OpenReview Portal.



### Implementation of the SAdam optimizer


To implement custom optimizers in Pytorch, the functions of the default `torch.optim.Optimizer` viz. `__init__` and `step()` need to be overriden.

- `__init__`: This function serves as the point where all the parameters for the optimizers are initialized. Thus the mandatory `params` parameter needs to initialized with a dictionary of hyperparameters necessary for optimization. It should be noted however `weight_decay` is not a part of the optimizer, but is a way of adding `L2` Regularization loss in Pytorch.

```

def __init__(self, params, beta_1=0.9, lr=0.01, delta=1e-2, xi_1=0.1,
             xi_2=0.1, gamma=0.9, weight_decay=1e-2):

    # Making the dictionary with all of the hyperparameters
    defaults = dict(lr=lr, beta_1=beta_1, delta=delta, xi_1=xi_1,
                    xi_2=xi_2, gamma=gamma, weight_decay=weight_decay)
    super(SAdam, self).__init__(params, defaults)

```

- `step` : A sample optimization step is mentioned in this function. `closure` is required for a few loss functions, where closure is utilized to terminate the loss function updates by the optimizer (not required for SAdam). The code given below performs 1 step on all of the parameters, and is almost a replica of the Adam optimizer, except that &beta;_2_ is time variant in SAdam, and instead of dividing by the square root for the second moment vector (denoted by `v_t` in the code given below), we use it as is. Intuitively, the larger decay caused due to this results in faster convergence, while the time variant hyperparameters make sure the convergence is not unstable.

```
def step(self, closure=None):
    loss = None
    if closure is not None:
        loss = closure()

    for group in self.param_groups:
        for p in group['params']:
            if p.grad is None:
                continue

            grad = p.grad
            state = self.state[p]

            # Initialize the derivatives if they haven't been updated yet
            if len(state) == 0:
                state['step'] = 0
                # Exponential moving average of gradient values
                state['hat_g_t'] = torch.zeros_like(
                    p, memory_format=torch.preserve_format)
                # Exponential moving average of squared gradient values
                state['v_t'] = torch.zeros_like(
                    p, memory_format=torch.preserve_format)

            # Extract all the hyperparameters for the optimizer
            lr, delta = group['lr'], group['delta']
            xi_1, xi_2 = group['xi_1'], group['xi_2']
            hat_g_t, v_t = state['hat_g_t'], state['v_t']
            gamma, beta_1 = group['gamma'], group['beta_1']

            # Update the step taken
            state['step'] += 1

            # L2 Regularization performed, if weight decay is initialized
            if group['weight_decay'] != 0:
                grad = grad.add(p, alpha=group['weight_decay'])

            time_step = state['step']
            beta_2 = 1 - gamma/time_step

            hat_g_t.mul_(beta_1).add_(grad, alpha=1 - beta_1)
            v_t.mul_(beta_2).addcmul_(grad, grad, value=1-beta_2)
            denom = time_step*v_t + delta
            p.addcmul_(hat_g_t, 1/denom, value=-lr)

return loss
```

### References
{% bibliography --cited %}