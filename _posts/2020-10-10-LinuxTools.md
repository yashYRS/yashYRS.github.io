---
layout : post
title : "My Personal Productivity Hacks: Open Source Tools for the Adventurous Linux User"
date : 2020-10-10
tags : [technical]
---

As a Computer Science engineer every miniscule jump in productivity in and around the workspace tends to have a butterfly effect, and ends up being a huge time savior. Over the years, I have disovered a few open source programs that have had a similar effect for me, and despite a oblique learning curve for most of them, they have become indispensible aspects of my working environment. It should be noted that most of these tools are specific to Linux, and anyone using other some other Operating System might not find much value from this post. Another common thread amongst everything listed here is that they are all open source, and have an active community. The configuration files for my system can be found [here](!https://github.com/yashYRS/dotfiles), although I would urge everyone to rice their own systems, since the configurability of each and every tool is what makes Linux so beautiful to work with.

### Newsboat

The amount of information that needs to be consumed on a daily basis keeps compounding over time, if not kept in check. There are many a technical blogs that one can follow to keep in touch with the latest trends in the industry. However, again filtering out the posts that are relevant to one's domain can end up being time consuming and tiresome. I used to navigate to each such blog every time a mail notification would come up. I came across the concept of RSS feeds and stumbled upon newsboat, when I looked around for suggestions to reduce the time taken for reading each of these blogs. On Homebrew, newsboat is included by default, however I had to download it in my Ubuntu system. It is essentially a HTML renderer, and enables one to read the RSS feeds on a terminal.

{% include image.html url="/images/productivity/newsboat_post.png" description="How a post would look like on a RSS-feed reader" %}

- There aren't many dependencies, and can be installed easily from one's relevant package managers.
```
$ sudo apt install newsboat
```
- Once install is complete, add the links to the blogs one wants to follow by adding it to the *.newsboat/urls* file in the .newsboat folder. At the end of the link, *tags* can be added to each of the links, to filter posts. 

{% include image.html url="/images/productivity/newsboat_bloglist.png" description="Newsboat greets you with the list of blogs added to the config" %}

- The feeds can be refreshed manually, however I have added this command to *crontab*, and the feeds therefore refresh every 30 minutes for me. 
```
	# To Manually refresh
	newsboat -r
	# To add to crontab
	crontab -l | { cat; echo "*/30 0 0 0 0 newsboat -r"; } | crontab -
```

Newsboat has vim bindings for navigating through the posts and blogs, although the key bindings can be configured as per one's preferences. To get a comprehensive deep dive into some of the features, would recommend going through the well maintained official [documentation](!https://newsboat.org/releases/2.10.1/docs/newsboat.html).


### I3wm

I remember being awestruck when I saw my friend Rohit working on his system. The speed at which he was switching between applications, the core idea of not having to use one's mouse at all while coding unless absolutely necessary was on display. I asked him what OS he was using, and he smirked telling me that it wasn't a different OS, just a different window manager called i3. I had decided right then and there to try it out, and have not looked back ever since. Traditional window managers, on most desktop environments are floating managers, where each window needs to be resized appropriately. The workspaces also need to be manually set everytime one wants to separate aspects of development. It is not much of a problem, except when using a tiling manager, all of this is handled automatically. There are many a tiling window managers, and i3 is just one of the many alternatives out there. It is my preference, owing to the configurability and the active community online, which comes around to my rescue, everytime I get stuck with something. It should be noted that using i3 out of the box, is not that great a idea. The true power can be only realized, once one tunes it to adjust it for own's needs. 

{% include image.html url="/images/productivity/i3_tiling.png" description="An example of the way i3 tiles applications" %}

For example, I have separated my workspaces into 6 categories (web, code, terminal, documents, calls, media) and by default the applications will always open in their respective workspaces, irrespective of where I give the command for opening them. Of course, one can easily move the applications around, according to immediate need. However this default action helps me in switching between my working environments with incredible speed. I have key bindings for virtually anything and everything that I do on a daily basis, and thus overall, the experience of using my system is very pleasant. In addition to the extensive flexibility that i3 provides, it is minimalisitc, and hardly uses up resources. If I haven't sold it enough already, here are some pictures of i3 setups from [unixporn](!https://www.reddit.com/r/unixporn), to inspire more people to use it. 

{% include image.html url="/images/productivity/i3_sample.jpg" description="Just start using it already" %}


### Ranger

I must have made it obvious by now, that I favour the terminal heavily. So when I came across a tree file manager completely based on the terminal, I had to switch to it. At the very onset, it might seem futile to push for something of this sort, since GUI file managers like nautilus have no problems whatsover. However the advantage of using ranger is that, it can do everything that a GUI manager can do, but in addition to that, has previews, which enables one to look at a snapshot of the contents of a file, before opening it. The vim bindings, configurability, speed brought about by ranger is incomparable. It is one of those tools that one just has to try before appreciating the beauty of it. 

{% include image.html url="/images/productivity/ranger_2.jpg" description="A sample of a preview of a video on ranger" %}

### An overextended epilogue

Almost everything that I have recommended above, becomes valuable only if one can touch type and ideally also is acquainted with vim bindings. I recommend [keybr](https://www.keybr.com) for learning to touch type, [monkeytype](https://www.monkeytype.com) for testing your typing speeds reliably, and [vimgenius](!https://www.vimgenius.com) for pratising your vim bindings. And again, this is more of a preference, but browsers don't really come better than [Brave](https://brave.com/) , which uses a Chromium engine called Blink at its core. The main advantage of using it is the complete control it provides over ads, cross-site cookies and trackers across websites. Besides the privacy benefits, it also has a great rewards program given out in form of their natively developed cyptocurrency called BAT (Basic Attention Token priced at $1.18 at the time of writing the post) and provides a local wallet to store them. And yeah, it also consumes way less resources compared to Chrome.