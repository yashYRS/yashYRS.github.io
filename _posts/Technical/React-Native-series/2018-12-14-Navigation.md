---
layout : post
title : "Navigation between Screens in React Native"
date : 2018-12-14
categories : Technical/React-Native-series 
---

*Note : Haven't put up any introductory post on setting up React Native Environment, since there are a lot of 
references available for that already. Also I recommend going through the following repository, it has an all
expansive list of react-native study material : [Repo link](https://github.com/jondot/awesome-react-native) *

Navigation in React Native is generally enabled through third party modules. Although native node modules to do 
the same can obviously developed, but the already existing ones work pretty well with practically no downsides. 
I recommend 'react-navigation', other methods could be opted for, however as a beginner I found using this 
module comparatively easier. 
[This](https://medium.com/the-react-native-log/thousand-ways-to-navigate-in-react-native-f7a1e311a0e8) offers a great comparative study. 

Installing React Navigation can be done in two ways -

	yarn add react-navigation 
	npm install react-navigation

Running any one of the two, will set up the project to use navigation properly. However it needs to be noted 
that you should never change the package manager to install different third party modules, ( and you will be 
using a hell lot of them ) since that leads to a plethora of problems cropping in terms of the consistency 
in the versions of the different modules supported by the respective package managers, also the .lock files get 
hampered with, which might lead to one having to rebuild the entire project, simply do a **yarn install** again, 
after removing the node-modules subdirectory entirely ( or **npm install** if that is being used ). Since the node-modules 
sub-directory can be so easily rebuild, it is generally not pushed while using version control for a project. 
Why the inconsistency happens is because of the inherent behaviour of how the two package managers yarn and npm 
install the dependencies required for a project. 
Yarn on one hand, makes a lock file right at the very onset, and uses that to always install a certain version 
of the dependencies, while npm will always go for the latest dependencies, and that is where the conflict can 
occur, since some methods get deprecated, and things that work in one environmental setup, might not work at all 
in a slightly different environment ( can be very unnerving for beginners, and takes a lot of trouble to understand why certain things suddenly stopped working ).

Now onto Navigation, here I will be discussing two kind of Navigatiors, both available with react-navigation, 
1. Stack Navigator , 2. Tab Navigator

Stack Navigator works as expected like a stack, with pages on being called, being pushed on the stack, and going back results 
in popping, thus we end up with the previously opened page. 

	// Sample Stack Navigator : 
		const AStack = StackNavigator(
		  {
		    A: {
		      screen: PageA
		    },
		    AA: {
		      screen: PageAA
		    }
		  },
		  {
		    initialRouteName: 'A',
		  }
		);

This will enable an environment where in navigation would be possible, however all of these need to be done manually by 
adding functions or other methods to actually navigate to other page. A possible analogy is the fact that making the 
navigator object is like knowing the route to a certain place, however we just knowing it, won't take us there, we explicitly 
need to go there as well. 

Unlike the stack navigator which goes deeper into the application, TabNavigator gives us quick 
access to pages that need to toggled more frequently. Like in the facebook app, we can toggle easily between the 
notifications, messages and friend requests pages, whilst clicking on some page/post enables for us to go deeper. 
	
	// Sample Tab Navigator, most of the code given is self explanatory... 
	export default TabNavigator(
		  {
		    AS: {
		      screen: pageA
		    },
		    BS: {
		      screen: pageB
		    },
		    CS: {
		      screen: pageC 
		    }
		  },
		  {
		    navigationOptions: ({ navigation }) => ({
		      tabBarIcon: ({ focused, tintColor }) => {
		        const { routeName } = navigation.state; 
		        let iconName = icons[routeName];
		        let color = (focused) ? '#fff' : '#929292';
		        return <MaterialIcons name={iconName} size={35} color={color} />;
		      },
		    }),
		    tabBarPosition: 'bottom',
		    animationEnabled: true,
		    tabBarOptions: {
		      showIcon: true,
		      showLabel: false,
		      style: { backgroundColor: '#333' }
		    }
		  },
		  {
		    initialRouteName: 'BS'
		  }
	);



For passing of data/objects between 2 screens, we pass the objects using a key-value pair using the navigate function : 

	<Button 
		onPress={() => { 
			navigation.navigate(
				'pageC',				// the page to go to 
				{ 
					key1 : Data1,
					key2 : Data2
				}						// data to pass to the page 
			);
      	}} 
    />

Now these passed values need to be retrieved as well, which can be done by adding the following in the NavigationOptions provided, at the start of the main class of a page : 

	static navigationOptions = ({ navigation }) => {
    	const { params } = navigation.state; // extract params, now using it requires params.data_objname   
      	return {
	        	headerTitle: 'Exercises',
	        	headerStyle: {	backgroundColor: '#333' }, 
      	}
    }

Appropriately modules ( third party modules and classes referred ) have to be imported for Navigation to work 
properly. Also by playing around with styling and by modifying parameters, highly complex navigation techniques replete with
animations can be made. A combination of the stack and tab navigators could be used to provide for the framework in case of a 
very complex workflow. As always, there is a ton more to this, however this should provide for a gentle introduction, and should also suffice for simple applications. 


That was my 2 cents on how to do navigate within React-Native, the reference code for this post can be found [here](https://github.com/yashYRS/Learning_ReactNative/tree/master/NavigationDemo). Hope this helped!!
