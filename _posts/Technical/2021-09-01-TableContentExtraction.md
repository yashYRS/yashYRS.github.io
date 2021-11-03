---
layout : post
title : "Instead of demanding a seat, build your table or better yet extract some tables"
date : 2021-09-01
categories : Technical
---

Table extraction fall under the umbrella of Document Intelligence, a relatively new research topic that deals with analzying and understanding business documents. The documents vary in style, layouts, fonts and generally have a complex template. Since digitisation of documents is a recent phenonmenon, majority of such documents are scanned copies of their printed counterparts. The poor quality of images, skew arising due to scans made in haste compound the difficulty of the problem. Especially in the financial domain, where the significance of every number and alphabet is paramount. Manual supervision along with some software aid is the current norm, however each day, efforts are made to reduce the amount of interventions required by humans. Extracting tables from these documents is one such sub domain, which has attracted a lot of researchers. Tables do not have a specified way of being constructed, and often the artistic proclivities involved in making tables look more presentable, add a layer to the difficulty of the problem. Most of the information in tables would make sense, if the relationships and contexts are known prior, as tables generally contain limited data. 


** Insert image showing some different and difficult kind of tables that might exist.

### Initial Approaches

- The first efforts to compartmentalize a report into tabular and non tabular areas were made in 2016, where existing object detection architectures (CNNs, R - CNNs and their variants) were trained to detect tables in pdfs. (ref here)

- In 2018, an end to end framwework was recommended in order to extract semantic structures of tables and paragraphs from documents. Pretrained word embeddings were in a fully conventional network to get decent results. (ref here)

- In 2019, a Graph Convolutional Network was proposed, which combined visual and textual cues from a document for achieving the same result of identifying semantic structures. (ref here)

### Layout LM

Almost every iteration brought with itself promising results, and had scope of application in real world datasets, 
However 2 aspects which the inital approaches hadn't tried, and was first explored by LayoutLM (ref here), were 
- Avoiding reliance on labelled data, since the number of such publicly known datasets were limited
- Trying joint pretrained models taking both textual and layout information into account. Up until now, the pretrained models were either CV or NLP models.

Proposed by a team at Microsoft Research Asia, LayoutLM constituted a novel approach to simply pretraining for document AI tasks, and recommended fine tuning for subsequent tasks as per need. At its core, LayoutLM can be considered as an extension of BERT to document AI tasks, as the inspiration in the model architecture is quite evident.


##### Model Architecture

Pre training

Layout LM v2 -> 


GTE -> 


Datasets -> 


### References