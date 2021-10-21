---
layout : post
title : "React Native, thou aren't as complex as thou seem"
date : 2018-12-14
categories : Technical
---

During my intership at Optimize IT Systems, my job entailed creating a basic curriculum for React Native, since the company wanted to migrate towards developing mobile applications with it. This post contains snippets from that curriculum along with a mention of the potential pitfalls that one might fall into as a beginner.

## Navigation between Screens in React Native
Navigation in React Native is generally enabled through third party modules. Although native node modules to do the same can obviously developed, but the already existing ones work pretty well with practically no downsides. I recommend 'react-navigation', [This](https://medium.com/the-react-native-log/thousand-ways-to-navigate-in-react-native-f7a1e311a0e8) contains a comparative study with regards to the options available.

Installing React Navigation can be done in two ways -

	yarn add react-navigation 
	npm install react-navigation

Running any one of the two, will set up the project to use navigation properly. Changing a package manager to install different third party modules leads to complications in in terms of the consistency in the versions of the different modules installed. The .lock files also get hampered with and often the only way out is to rebuild the entire project, which can be done by running **yarn install** again, after removing the node-modules subdirectory entirely ( or **npm install** if that is being used ). Since the node-modules sub-directory can be so easily rebuild, it is generally not pushed while using version control for a project. 
Yarn on one hand, makes a lock file right at the very onset, and uses that to always install a certain version of the dependencies, while npm will always go for the latest dependencies, and that is where the conflict can occur, since some methods get deprecated, and things that work in one environmental setup, might not work at all in a slightly different environment 

Two most popular Navigatiors available with react-navigation are,
1. Stack Navigator , 2. Tab Navigator

Stack Navigator works as expected like a stack, with pages on being called, being pushed on the stack, and going back results in popping, thus we end up with the previously opened page. 

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

This will enable an environment where in navigation would be possible, however all of these need to be done manually by adding functions or other methods to actually navigate to other page. A possible analogy is the fact that making the navigator object is like knowing the route to a certain place, however we just knowing it, won't take us there, we explicitly 
need to go there as well. 

Unlike the stack navigator which goes deeper into the application, TabNavigator gives us quick access to pages that need to toggled more frequently. Like in the facebook app, we can toggle easily between the notifications, messages and friend requests pages, whilst clicking on some page/post enables for us to go deeper. 
	
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

Appropriately modules ( third party modules and classes referred ) have to be imported for Navigation to work properly. Also by playing around with styling and by modifying parameters, highly complex navigation techniques replete with animations can be made. A combination of the stack and tab navigators could be used to provide for the framework in case of a very complex workflow. 


## Working with Databases
A local database is almost a bare-minimum for the making of even the simplest of apps, and like any other technologies, 
there's a lot to choose from in terms of what one might want to use in their application, to accomplish local storage. 
[This](https://aboutreact.com/local-database-in-react-native-app/) offers a great overall outlook for the options available out there to implement local database in React-Native apps.

### Sqlite :
It uses a third party module called : 'react-native-sqlite-storage', thus same needs to be added by yarn 
	
	yarn add react-native-sqlite-storage 
	yarn add react-navigation 

Now, this isn't enough, since we need to provide some extra information in the android-specific folder, for these databases to work properly.

Step 1 : Add to the dependencies section in android/app/build.gradle

	implementation project(':react-native-sqlite-storage')

Step 2 : Add to the android/settings.gradle

	include ':react-native-sqlite-storage'
	project(':react-native-sqlite-storage').projectDir = new File(rootProject.projectDir, '../node_modules/react-native-sqlite-storage/src/android'

Step 3 : Add to MainApplication.java 

	import org.pgsqlite.SQLitePluginPackage // import statement 
	new SQLitePluginPackage() // append to getPackages

After following the above steps, the application is now ready to use sqlite-database. The basic syntax of an sqlite execute function is as follows 
		
	db.transaction(function(txn) {
  		txn.executeSql(
		    query,                 //Query same as in Sqlite
    		argsToBePassed[],      //Argument to the query 
    		function(tx, res) {}   //ToDo with the result
  		);
	});

However before it is used, importing **openDatabase** is necessary, and opening the database is necessary as well. 
Here though the database being accessed does not necessarily have to be created before hand, if nothing is present,
a new albeit empty database is created. We can even manipulate existing databases and is precisely the reason why we 
would even consider using SQLite plugins, since although it is used across domains in myriad applications, the plugin provided
in React Native is slower compared to other alternative, for eg : Realm.

	import {openDatabase} from 'react-native-sqlite-storage'
	var db = openDatabase({name : 'name-of-database.db'})



Thus for illustration a sample operation of all the operations are being shown below : 

#### Query a table
	db.transaction(tx => {
	      		tx.executeSql(
	        		'SELECT * FROM table_user where user_id = ?', [this.search_user_id],
	        		(tx, results) => {
	        			// DO SOMETHING WITH THE RESULTS, DISPLAY OR SET VALUES 
	        		}
	        	)
			}
		);

#### Insert into a table
	db.transaction(tx => {
	      		tx.executeSql(
	        		'INSERT INTO table_user (user_name, user_id) VALUES (?,?)', [this.state.name,this.state.id],
	        		(tx, results) => {
	        			// After execution of the insert statement, this function gets executed 
	        		}
	        	)
			}
		);

#### Create a table
	db.transaction(tx => {
	      		tx.executeSql( 
	      			'CREATE TABLE IF NOT EXISTS table_user(user_id INTEGER PRIMARY KEY AUTOINCREMENT, user_name VARCHAR(20)' 
	      		)
			}
		);

#### Update values in a table
	db.transaction(tx => {
	      		tx.executeSql(
	        		'UPDATE table_user set user_id = ?. user_name = ?', [this.state.id, this.state.name],
	        		(tx, results) => {
	        			// After execution of the update statement, this function gets executed 
	        		}
	        	)
			}
		);


#### Delete
	db.transaction(tx => {
	      		tx.executeSql(
	        		'DELETE FROM table_user where user_id = ?', [this.search_user_id],
	        		(tx, results) => {
	        			// After delete, this function gets executed 
	        		}
	        	)
			}
		);

A very common error is to not handle the data types appropriately while trying to do any CRUD operation on the database, 
especially if the state variables are being used to change/update/insert values in the database. For eg: use parseInt(str,10) 
if the required type is Integer for a particular column in database. A good reference for an IOS-app demo for SQLite is available in this blog [post](https://brucelefebvre.com/blog/2018/11/06/react-native-offline-first-db-with-sqlite/).


### Realm :

Realm is not a database in a very traditional sense, since it cannot be used universally. It has been designed specifically 
for mobile devices, although it makes up for this disadvantage with substantially faster speed, and it's simplicity of design.
At the very heart of it, it uses JS objects which are dynamically mapped to a full, custom database engine. Extremely complex 
data models can be modelled using Realm, and is thus is a very popular local database choice for mobile applications. 	


	yarn add realm 
	react-native link realm 

Similar to sqlite, a few additional steps are required to finish the setup

1) In the **settings.gradle** file : 
	
	include ':realm'
	project(':realm').projectDir = new File(rootProject.projectDir, '../node_modules/realm/android')

2) 	In the **android/app/build.gradle**, if gradle version < 3.0, then replace implementation with compile : 
	
	implementation project(':realm')

3) In **MainApplication.java** : 

	import io.realm.react.RealmReactPackage ; 

And inside the getPackage() function after MainReactPackage(), 
		
	new RealmReactPackage() ;

#### Making a Schema
Making a schema is equivalent to designing the table structure in SQL. However, the functionality provided by Realm, enables making even extremely complex schemas, very easy to design, since overall design is very similar to the object-oriented design.

	cont Xschema = {
		name : 'X',
		primaryKey : 'id',
		properties : {
			name : 'string',
			id : 'integer',
			birthday : 'date',
			achievements : 'achievement[]',
			death : 'date?',
		}
	}

Here, *name : 'X'* isn't the property of the network, it is instead serving the purpose of a alias. Thus, every Xschema object will have the same name-alias, for referring. However, the *name* inside the *properties* block is a property of each object. There are options galore for datatypes [docs](https://realm.io/docs/javascript/latest/). #e can use our own custom datatypes, i.e. we could use embedded schemas in our design, to model extremely difficult situations extremely easily.

Appending a **[]** at the end of some datatype implies that the entity is a list containing those datatypes variables, similarly  a **?** implies that using the parameter is optional. Again, there is a lot more options to make better schemas, and a look into the [docs](https://realm.io/docs/javascript/latest/) might prove worthwhile. 


#### Insert a Schema
The following code block can be used for inserting an entry in some table, in realm referred to as making a object of a schema

	realm.write( ()=>  {
		realm.create('X',{
			id : parseInt(this.state.id, 10) ,
			...
			..
			.
		}) ; 
	});

Thus, after opening the 'X' type schema, we create an object of that instance, the reference for which may or may not be saved, as per needs. It must be noted that the realm object needs to be passed, across the screens for it to be accessible everywhere, or the path to the same needs to be passed as props.

#### Query a Schema

1. Simplest query , return all the objects of a particular schema. 
	
	a = realm.objects('X') 

2. Equivalent to a where clause, using filter. 
	
	a.filtered('condition1 AND condition2') ; 

where a is the collection of all objects of that particular schema, as said before

#### Delete a Schema
For deleting entities, we will need object references of everything we need to delete, thus we use the query function first to get those references, then we call the delete operation. An example - 
    
    realm.write(() => {
        a = realm.objects('employee').filtered('id =' + parseInt(this.state.id,10))
		if ( a.length > 0 ) {
			realm.delete(a) ; 
		}
    });


#### Update a Schema
Update is very similar to delete, we simply get the applications, and then we simply update using the object references, just as assignment to any other object is done. An example : 

    realm.write(() => {
        obj = realm.objects('employee').filtered('id =' + parseInt(this.state.id,10)) ; 
        for (i = 0 ; i < obj.length ; i++ ) {
            obj[i].param1 = some_variable ; 
            ...
            ..
            .
        }	


## Shared Preferences
Shared Preferences in Mobile Application Development refers to the data that is stored in the app itself, for customizing the overall experience of using the application for a user. These are data that persists, even if the the app is closed or the device is stopped. Also these data values can be accessed across the application, as in every page in the app will have access to this data. 

One of the simplest ways to implement this feature is to use the AsyncStorage functionality provided by react-native as a basic component. Thus since it is not a third party module, no extra setup is required for using this. A disadvantage of Async Storage is that, although the data stored is persistent, it stores everything in an unencrypted form. However, in most use cases, the data stored via Shared preferences isn't all that sensitive and so is widely used. 

A few important things to note about Async Storage is the fact that it stores data in key-value pairs [ like a dictionary in Python ], and it can only store value in string format. Thus for any other datatype, the responsibility of conversion handling is passed on to the app itself. 

All methods in Async Storage return a Promise object ( an object that either has a value or may produce a value in future ), thus, it follows that almost all the times any method of async storage is used, we end up using it within Async-Await blocks. In loose terms, it is a way of handling promise objects in a better fashion, async if prefixed before a function implies that the function will always return a promise, whilst await makes the application wait for the promise result to get resolved. 
For detailed information on Promise objects [link](https://medium.com/javascript-scene/master-the-javascript-interview-what-is-a-promise-27fc71e77261) and for Async-Await concepts [link](https://hackernoon.com/6-reasons-why-javascripts-async-await-blows-promises-away-tutorial-c7ec10518dd9)

After understanding Promise objects, and Await-Async calls, it becomes pretty straight-forward to use Async-Storage, however to avoid the application from crashing, exception handling is critical, and needs to cover cases in which promise returned is NULL.

Some of the operations are shown here below 

Get Data  - 

	try {
      	AsyncStorage.getItem(
        	'Key').then(data => {
          	this.setState({another : data}) // code after **then** dictates what is to be done with the data retrieved
        	}) ;
     	} catch (error) {
       		console.log('retrieve not happening') 
     	}

Insert/Update Data - 

	try {
      AsyncStorage.setItem('Key', JSON.stringify(this.state.textValue)); // set state variable to be equal to key's value
    } catch (error) {
      console.log('Couldn\'t save') ;
    }


Delete Data - 

    try {
      AsyncStorage.removeItem('Key', (err) => {
           console.log('Deleted...');		// code after comma, dictates action after deleting the value associated with key
      });		
    }
    catch(exception) {
      console.log('Delete not happening') ; 
    }


## Card View

CardView, a very popular Material Design resembles a frame, and has a very elegant styling already coded up for itself. It is a very potent tool to use, when information of the same kind needs to be displayed somewhere in the application. 
is the [docs](https://developer.android.com/reference/android/support/v7/widget/CardView) detail the the philosophy behind this design.

Add the third party modules using your default package manager, 

	
	yarn add react-native-elements 
	yarn add react-native-vector-icons
	react-native link react-native-vector-icons 

Note : Not adding react-native-vector-icons will result in the code not working, since Card Component requires that module for the initial auto-generated code added during installation to work. 

Thereafter using a CardView is exactly similar to how a normal View would be used, 

Import it, 
	
	import {Card} from 'react-native-elements'

Wrap some content in it, 

	<Card>
		<Text> some text </Text>
		...
		..
		.
	</Card>

And whatever is wrapped gets displayed, we don't need to worry about the size of the card, it adjusts according to the content it has, although we need to careful of the fact that the screen size might not accomodate all the cards. Thus we wrap the overall Content within ScrollView, so that we can view everything there, 

#### Common errors

- SrollView Child layout must be applied through .... error type : This happens because in ScrollView, we can't have styling 
done through the normal *style* option, instead we have to use : 
	
	contentContainerStyle = {styles.someStyle} 

- ScrollView, does not crash, but it does not scroll either. In this case, generally adding one option to ScrollView styles 
component ( here someStyle in the styles Stylesheet ) makes the code work, 
	
	flexGrow : 1 

## Custom Camera

Since, the **Camera** component used here is an in-built component, provided by the expo class, using it doesn't require any kind of external library installation. However, for using the Camera in Android , the app should have the necessary mandation to use the device's Camera. For the same, we use the **Permission** component provided by expo. The Camera component simply gives us the view of the camera itself, it does not involve using intents to use the default Camera App in a given android device. Thus every functionality of the camera, from mechanisms to click pictures, to deleting pictures, to flipping the camera needs to be done explicity through code. Again, the photos captured do not get saved themselves, they need to be save explicitly by connecting the **FileSystem** component. using any database mechanism. Here we use 'react-native-simple-store' which is a 3rd party module (thus needs to be added manually using package managers) , a wrapper for Async-Storage, 

Thus import statement includes 

	import {Permissions, Camera , FileSystem} from 'expo' ; 
	import 'react-native-simple-store'



For looking at the camera contents, we simply use \<Camera> \</Camera> as we would use \<Text> or \<Button>, we style it appropriately, however the only difference is we use Modal View to embed the Camera view, and the advantage of using a modal view is the fact that we can actually set as to whether the Modal view is visible at some point, or whether it isn't.
It becomes really useful with Cameras, since we simulate opening and closing of the camera by manipulating the visibility of the container modal view. 


	<Modal
		animationType="slide"
		transparent={false}		
		visible={this.state.is_camera_visible}		// control visibility by a state variable...
		onRequestClose={() => { this.setState({ is_camera_visible: false }); 
	}}>

Now as a sub element, to this Modal, we could define views, which will have the Camera component, along with a few buttons, meant to serve different functionalities of the camera. The styling of the buttons, camera screen component can be modified to one's suiting and serve the customization. A sample is given below 

	<Camera style={/* style */} type={this.state.type} ref={ref => { this.camera = ref; }}>
		<View style={/* style for Body */}>
			<View style={/* style for Button */}>
				<Button {/* close camera */} />
				<Button {/* flip- camera */}/>
				<Button {/* capture-photo */}/>
			</View>
		</View>
	</Camera>

here, one important point that needs to be emphasized upon is the setting of the **this.camera** variable, we connect the Camera View component inside Modal, to the actual Camera using this, very reference. Thus playing around with these, we can even simultaneously use both the front and back cameras, also the **type** here signifies, whether the front or the rear camera is being used, therefore a state variable can be used to keep track of the current type, and changing to a different one, would involve, simply changing the state variable's content.

However, before using any of these functionalities, as said before permissions need to be sorted for Android Devices. A way of securing permissions is shown below : 


```
 	componentWillMount() {
    	Permissions.askAsync(Permissions.CAMERA).then((response) => {
      		this.setState({ has_camera_permission: response.status === 'granted' }); 
    	});
  	}
```
componentWillMount code, executes before any page has been rendered, thus including this, would invoke an alert, asking for permissions to use the Camera. Here a state variable, has_camera_permission is used to store whether or not permission has been availed, so the button to launch the camera can use this status as a condition, to open up camera, only if 
status == granted.

The code to take a picture is given below : 

	if(this.camera){ // check whether there's a camera reference
		this.camera.takePictureAsync().then((data) => {
			// code for processing the picture captured, stored in data... 
		});
	}

Now, we have to store the pictures that have been captured, using FileSystem another component for which expo provides support. Importing the component is necessary as indicated before, we use a variable to store the location of the directory in which  all the photos captured will get stored. Here we use *react-native-simple-store* in conjunction with *FileSystem* component to store the pictures in the app itself. 

	this.location = FileSystem.documentDirectory ; 

Here *location* will now have a unique location at which it is being stored, however it won't be accessible by the phone itself, since by default the location is in the Android OS. For changing this to save things to your Gallery, or to change it up to have things saved up on some other default location [Camera Roll API](https://facebook.github.io/react-native/docs/cameraroll.html#savetocameraroll) can be used. 

Thus inside the *then* construct for the code to capture pictures, we put in mechanisms to store the photo. The photo is accessible via the *data* variable. For every photo we get a unique *file-path*, then we add the following : 

	FileSystem.moveAsync({
		from: data.uri,
		to: file_path
	}).then( (response) => {
		let photo_data = {
			key: // some key 
            name: // some name 
		};
		store.push('database_name', photo_data);
	});

This function simply moves the photo from the obscure location it is at, to a location somewhere either local or external (in that case, we have to take permission to access device content's as well) in the app. *photo_data* here is used as a temporary variable to eventually store the photo in a database (Async Storage) for the app. So at a later point in time, we can view the photo by retrieving it using the key that was used to store it in the first place. A lot more can be done, in terms of enhancing functionalities of the camera, styling the app, some other 3rd party modules can be used that aren't supported by expo, and thus projects for those can be made using 'react-native init'. However, using expo components always holds the advantage of not having to install external packages, also there not being any effort whatsover to make changes specific to any particular platform ( neither Android nor IOS ). 


## Integrating Maps

Before integrating Maps add the third party modules
```	
	yarn add react-native-elements 
	yarn add react-native-vector-icons
	react-native link react-native-vector-icons 
	yarn add react-native-maps
	react-native link react-native-maps
```

Now, for using any Map Service ( eg. Google Maps, OpenLayers, TomTom ) we need to generate API keys to render the Map View. Thus after generating the appropriate keys, we add it to our Android.manifest file as follows *demo for google API given*

```html 
      <meta-data
        android:name="com.google.android.geo.API_KEY"
        android:value="---- Insert your own key ----"/>
```
A common error that occurs on running the application at this very instance is as follows, **android.support.v4.accessibilityservice.AccessibilityServiceInfoCompat Error** 

A solution for this is to replace the line 

		compile/implementation project('react-native-maps')

with the following code segments, 
        
		compile(project(':react-native-maps')) {
			exclude group: 'com.android.support'
			exclude module: 'appcompat-v7'
			exclude module: 'support-v4'
		}

Now, hereupon we can render the MapView anywhere in the application. It is generally better to render the map with absolute coordinates, an example of a scheme for full screen map shown here :- 

```
	map: {position:'absolute', top:0, left:0, right:0,bottom:0}
```

Before rendering the Map, import all required components
	
```
	import MapView, {Marker} from react-native-elements
```

MapView has a *Region* variable, which has in 4 parameters viz, latitude, longititude, latitudeDelta , longitudeDelta to specify what area the MapView should be showing. Initial Region for the Map should always be shown, a sample setup is shown here, 


	<MapView
		ref = "Mapfunction"
		style={styles.map}
		initialRegion={
			{
				latitude: 37.78825,
				longitude: -122.4324,
				latitudeDelta: 0.00922,
				longitudeDelta: 0.00421
			}
		}
		<Marker
			ref = "MapMove"
			coordinate={
				{
					latitude : 37.78825,
					longitude : -122.4324
				}
			}
		/>		
	</MapView>

**ref** is used to call the methods native to a particular component. Thus, for example for a button focus, blur methods are provided. So using ref, we create a object like entity which we used to call that method. So here, using any method for the MapView would involve the following, **this.refs.Mapfunction.methodToCall**. 

The code above renders the Map to be set to the region specified, with the center of the map being marked by the Marker component and the expanse of the map being the variables latitudeDelta and longitudeDelta.

Say, if we get the coordinates of a new location through some other means in our application, then we can change our MapView to refer to those coordinates and our marker to point to that very location in the following way, 

	this.refs.Mapfunction.animateToRegion( {
			latitude : Number(this.state.latitude),
			longitude : Number(this.state.longitude),
			latitudeDelta : 0.00922,
			longitudeDelta: 0.00421,
		},
        100 
	); 
    this.refs.MapMove.animateMarkerToCoordinate( {
			latitude : Number(this.state.latitude),
			longitude : Number(this.state.longitude),      
		},
		100
	) ; 

The ref variables are in line with what we had set while rendering the components, also we assume the new latitude and longitude values are stored in state component of the application.


### Geocoding
Geocoding is the process of converting human readable addresses to latitudes and longitudes, thus while searching for some location, Geocoding comes into place, since the user would be putting in the name of the addresses, and thus we need to generate the corresponding geocoded values, for any further application, example getting the route. 

Thus, for doing the same add one more package to our project, 

	yarn add react-native-geocoding
	react-native link react-native-geocoding

Thereafter we add another API key to our application, one which is capable of doing geocoding. Thus amongst the Google API's the *Places* API suffices. Some other key could also be used. 

	import Geododer from 'react-native-geocoding'
	Geocoder.init('---- Insert your API key here ----- ')

Now, a sample conversion of a place's address to latitude and longitude is given here 

	Geocoder.from(this.state.sampleAddress)
	.then(json => {
		var location = json.results[0].geometry.location;
		console.log(location.lat); 
		console.log(location.lng); 
	})

Here, we get the 1st location result that we get, and retrieve that result's latitude and longitude. If all the results are needed, we can use the json.results[] area to access all the results. It should be noted that the scope of the location variable here is local, thus to access these values anywhere else, we must store these to some variables, and for 
doing the same, differing datatypes must be handled with extreme care. 

The reverse of this process called *reverse-geocoding* can also be used using the same third party module.

Another thing worth exploring is the SearchBar component provided by 'react-native-elements'. Generally used in conjunction with React Native Maps, it is a very efficient way to display the results of a search and to choose amongst the options. 

A sample code snippet, which is self explanatory is provided here, 

	<SearchBar 
		data = {some array component}
		containerStyle = {some stylesheet component}
		onChangeText= {some method }
		onSubmitEditing = {some method}
		placeholder="Type here ...."
	/>

Here the data component is the array where the search will be performed, and from which the results will be finally refined. Other components are self explanatory. For discovering other functions associated with the SearchBar component, [link](https://react-native-training.github.io/react-native-elements/docs/searchbar.html)

_Note : Haven't added details on setting up a React Native Environment, since there are a lot of references available for that. I recommend going through this [repository](https://github.com/jondot/awesome-react-native) if you wish to explore React Native in more depth