---
layout : post
title : "Some of my favourite mini-side projects"
date : 2019-06-18
categories : Projects
---

Like any other beginner to the field, I have experimented with different technologies, often times collaborating with others to learn more about a particular topic that spurred interest. That over time, has led to me making weird, unsurprisingly unsustainable projects in short bursts. However each of these projects acted as a gateway for me into a new domain, and therefore are memorable for me.

### [Earthquake Detection System](!https://github.com/yashYRS/DetectEarthquake)

The theme for Microsoft's Code Fun Do++ for the year 2018, was Earthquakes. Each team was to make something that would help in the overall management of natural disasters.  [Tanmay](!https://github.com/tanmay2298) and  [Chhayank](!https://github.com/chhayankjain) were my teammates for the event. We had noticed that most other teams were working on either the prediction or management of earthquakes (making prototypes of platforms to crowdfund resources to distribute for alleviating the distress in affected areas). While brainstorming, we got to know that it takes considerable amount of time (as much as 20 minutes) for the disaster management authorities to be notified about any natural disaster that takes place. We instantly started working on something to reduce this time gap. Our final solution was extremely minimalistic and simple. We wanted to use live feeds provided by the government owned surveilance tools (cameras/satelite data) and periodically scan the frames (say every 30 seconds). For every camera, we would identify a static background object like a lamp post, or a zebra crossing or a street signal. These static background objects can be occluded owing to some foreground objects (humans, cars, bikes ...) appearing. However, the idea was that we would have multiple such live feeds that were being scanned, and the chance of the occlusions appearing in sync in all of these cameras was virtually nill. In case of an earthquake, the shaking of the ground, the camera would result in all of the cameras reporting a change in the position of these static objects, and in case of this, we would immediately ping the concerned authorities.

#### Pseudo code for detection of discrepancy using lanes

The nmber of common lines between 2 consecutive frames is high but as the earthquake starts, due to the shifting of the lines, the average keeps dropping due to the constant shaking of everything, and a alert is issued
The assumptions made were that, the color for demarkating lanes are generally white. Although, it wasn't a hard assumption, since there was a provision to override the color for cities with different coloring schemes.

Here `frame` refers to the current frame being examined, and `upper_white` & `lower_white` controls the color range to identify car lanes. The loop given here is run periodically (every 30 seconds). `ave_list` refers to the list that contains the historical ground truth against which the current extraction is compared.

```
# Flag to show frame status
frame_status = POSITIVE

# detecting white lanes of a road ....
hsv = cv2.cvtColor(frame, cv2.COLOR_BGR2HSV)
mask = cv2.inRange(hsv, lower_white, upper_white)

# Finding the edges on the road
edges = cv2.Canny(mask, 75, 150)
edges = cv2.GaussianBlur(edges, (5, 5), 0)

try:
    # Detect white lines in the frame 
    lines = cv2.HoughLinesP(edges, 1, np.pi/180, 100, minLineLength=20)
    ave_list.append(lines)

    # If lines are not detected for the current frame, return the same 
    if len(lines) > 0:
        # Function to match the current extraction with the historical extraction 
        same = check_lines(ave_list)

		# If the number of similar lines is lower than a threshold
		# however the number of lines in the frame is high
		# the status of the frame is set to show negative
        if same < same_thresh and len(lines) > line_thresh:
        	frame_status = NEGATIVE
        else:
        	# If the status continues to be positive, the historical data is scrapped
        	# to keep the current extraction as the basis for future comparisons
        	ave_list = [lines]
    else:
    	frame_status = POSITIVE
except Exception as e:
    frame_status = NEGATIVE
```


Another experimental feature of the prototype we had created, was to predict earthquakes based on a long standing theory, that animals can often times sense an impending disaster, and start getting fidgety hours before the actual calamity. As this hadn't been proved yet, we wanted an accompanying analyzer along with our primary earthquake detection, which would capture animal movements in a zoo/ safari. We tracked their usual entry and exit from frames and stored this information into a database. Our goal was to collate this data with the times at which the earthquake was detected, and in case a correlation was found, animal movement could be permanently be used as a measure to predict occurrences of an earthquake. 

   
#### Pseudo code for recording entry and exit of animals

An assumption made was that, the live feeds that were to be provided for the zoos, to record animal movements would track a single animal per camera. Thus, identifying the animal in every iteration is not required, and the detection of any large moving object can be considered equivalent to the presence of an animal in the frame. Each `frame` is processed as follows
```
# By default, every frame is considered be to empty
occupied = False

# resize the frame, convert it to grayscale, and blur it 
frame = imutils.resize(frame, width=500)
gray = cv2.cvtColor(frame, cv2.COLOR_BGR2GRAY)
gray = cv2.GaussianBlur(gray, (21, 21), 0)

# if the first frame is None, initialize it
if first_frame is None:
    first_frame = gray
    continue

# compute the absolute difference between the current and first frame
frameDelta = cv2.absdiff(first_frame, gray)
thresh = cv2.threshold(frameDelta, 25, 255, cv2.THRESH_BINARY)[1]

# dilate the thresholded image to fill in holes
thresh = cv2.dilate(thresh, None, iterations=2)

# find contours on thresholded image
cnts = cv2.findContours(thresh.copy(), cv2.RETR_EXTERNAL, cv2.CHAIN_APPROX_SIMPLE)[0]

# loop over the contours
for c in cnts:
    if cv2.contourArea(c) < min_area:
        continue

    # If contour is large, something is occupying the frame
	# Therefore, record entry if previous frame was empty 
    if prev_status is False:
        occupied = True
    	save_entry_time(datetime.datetime.now(tz=timezone.utc))
        break

# if none of the contours were big enough, current frame is empty
if occupied is False and prev_status is True:            
	save_exit_time(datetime.datetime.now(tz=timezone.utc))

# previous status of frames updated
prev_status = occupied
```

### [Sudoku Solver](!https://github.com/yashYRS/Sudoku_Solver)

I had a long weekend somewhere around my 4th Semester, and was feeling bored. I had just completed the CS - 231n course, and wanted to start training models to solve for various tasks. I had also learnt the basics of image processing and wanted to work on something that required the same. An automated sudoku solver happened to be the first suggestion that I came across online while searching for potential ideas that I could work on that required both image processing and neural networks. In either case, it turned out to be a fun weekend, as I implemented it over the course of 3 days. The pipeline of the project was as follows:

- Identifying each individual square in a sudoku puzzle: The hard assumptions made for the input is that, the sudoku image has to be non-skewed, and the grid lines in the Sudoku have to be clear. If the input satisfies these conditions, puzzles are extracted from the entire sudoku image. In case, the input can't be processed, there is a provision to input the puzzle manually. The pseudo code for extraction -

```
# Convert to gray scale
gray = cv2.cvtColor(sudoku_image, cv2.COLOR_BGR2GRAY)
# Blur to be able to detect all the edges in the image clearly
blur_gray = cv2.GaussianBlur(gray, (5, 5), 0)
# Use the Canny edge detector to get the edges on the screen
edges = cv2.Canny(blur_gray, 30, 90, apertureSize=3)


# Find lines greater than 160 pixels in length
lines = cv2.HoughLines(edges, 1, np.pi/180, 160, 0, 0)

# sort the lines based on the value of Perpendicular
lines = sorted(lines, key=lambda line: line[0][0])

# Filter the lines to only contain horizontal and vertical lines
h_list, v_list = filter_lines_based_on_angle(lines, puzzle)

# Find the intersection between horizontal and vertical lines
points = get_intersection(h_list, v_list)

# If number of intersection points detected is not 100
# the user is asked to enter the board manually
if len(points) == 100:
	# After identifying points, square images are formed from the points 
	puzzle = extract_individual_digits(image, points)
else:
	puzzle = enter_board_manually()
```

- Extracting square images from the points in the image:

```
def_indidual_digits(image, points)
    board = []
    for row in range(9):
        row_board = []
        # goes till 9, since last diagonal not needed

        for column in range(9):
            x1, y1 = [int(i)+3 for i in points[row*10 + column]]

            # coordinates of the diagonals of the rectangle
            x2, y2 = [int(i)-3 for i in points[row*10 + column + 11]]

            # area of 1 box, each box has 1 digit
            temp_img = img[y1:y2, x1:x2]

            if(temp.size != 0):

                # to maintain uniformity with the model's requirements
                cv2.line(img, (x1, y1), (x2, y2), (0, 0, 255), 2)

            	# Predict the digit found using a trained digit recognizer model
                row_board.append(predict_image(model, temp_img))

        board.append(row_board)
    return board
```

- Identifying the digits in each square image: I had initially trained a shallow neural net (Conv2d layer, Max Pool layer followed by a couple of fully connected layers) on the MNIST dataset for identifying the digits from the individual squares. I had added a few random images with empty squares and added them with the tag -1 to the MNIST dataset for being able to predict on empty squares as well. However later, I changed the pipeline to a Logistic Regression model trained on the original dataset and a simple check before prediction to check if the input image contained a digit. The pseudo code -

```
# model_path is the file, from where the trained model is loaded
model = LogisticRegression()
model.load_state_dict(torch.load(model_path))

# Preprocess and flatten the image for testing
image_tensor = torch.flatten(test_transforms(image))

# If the image is non empty, then the digit is identified by the model
if torch.sum(image_tensor) > non_empty_thresh:
	output_arr = model(image_tensor).detach().numpy()
    digit_identified = np.argmax(output_arr)
else:
	# The square does not contain any number, return -1 to denote the same
	digit_identified = -1
```

- Solve the sudoku, based on the information gathered, and display the solution: I simply used backtracking to solve the sudoku. There are innumerable posts explaining backtracking ([refer](https://www.geeksforgeeks.org/sudoku-backtracking-7/)), hence am not providing the pseudo code here. 

### [Alpha Beta Pruning to make a game engine](!https://github.com/yashYRS/Tic-Tac-Toe)

The perception that I had about AI when I was in high school was almost entirely built up by the hype around how no chess grandmaster was capable of beating a chess engine (that and JARVIS in Ironman xD ). It was inevitable that the first thing I started reading about, after learning the fundamentals of programming was how to make a chess engine. Today, I appreciate the intricacies of AI and my understanding of the field has evolved since, but when I read about alpha-beta pruning, the elegance of it all to make engines suitable for games with perfect information, removed some of the mystique behind something I had been utterly fascinated by. The game that I chose to make was Tic-Tac-Toe, since I did not want to spend time, on coding up the graphics of chess, but was just interested in making alpha-beta pruning work. It took me a weekend's time to make this game, but till date, whenever I am bored, I just fire up the game and start playing. There are a plethora of posts explaining alpha-beta pruning ([refer](https://iq.opengenus.org/alpha-beta-pruning-minimax-algorithm)), if anyone starting out wants to explore it.

