---
layout : post
title : "Shared Preferences in React Native"
date : 2018-12-17
categories : Technical/React-Native-series 
---

_Note : Haven't put up any introductory post on setting up React Native Environment, since there are a lot of 
references available for that already. Also I recommend going through the following repository, it has an all
expansive list of react-native study material : [Repo link](https://github.com/jondot/awesome-react-native)_

Shared Preferences in Mobile Application Development refers to the data that is stored in the app itself, for 
customizing the overall experience of using the application for a user. These are data that persists, even if the
the app is closed or the device is stopped. Also these data values can be accessed across the application, as in 
every page in the app will have access to this data. 

A very potent and simple way to implement this feature in React Native is to use the AsyncStorage functionality provided
by react-native as a basic component itself. Thus since it is not a third party module, no extra setup is required to be done
for using this. However one disadvantage of Async Storage is the fact that, although the data stored is persistent, it 
stores everything in an unencrypted form. However, in most use cases, the data generally stored via Shared preferences isn't 
all that sensitive and so is widely used. 

A few important things to note about Async Storage is the fact that it stores data in key-value pairs [ like a dictionary in 
Python ], and it can only store value in string format. Thus for any other datatype, the responsibility of conversion 
handling is passed on to the app itself. 

All methods in Async Storage return a Promise object ( an object that either has a value or may produce a value in future ), 
thus, it follows that almost all the times any method of async storage is used, we end up using it within Async-Await blocks. 
In loose terms, it is a way of handling promise objects in a better fashion, async if prefixed before a function implies that 
the function will always return a promise, whilst await makes the application wait for the promise result to get resolved. 
For detailed information on Promise objects [link](https://medium.com/javascript-scene/master-the-javascript-interview-what-is-a-promise-27fc71e77261) and for Async-Await concepts [link](https://hackernoon.com/6-reasons-why-javascripts-async-await-blows-promises-away-tutorial-c7ec10518dd9)

After understanding Promise objects, and Await-Async calls, it becomes pretty straight-forward to use Async-Storage, however
it should be noted that to avoid the application from crashing, exception handling is critical, and needs to cover cases in 
which promise returned is NULL.

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



There are a plethora of methods supported by Async Storage ( eg. for handling mutltiple requests at a time, clearing 
everything at one go.... ), and to utilize the full potential of this, a look into the [docs](https://facebook.github.io/react-native/docs/asyncstorage) might prove helpful.
Also, there are a lot of wrappers, available which use AsyncStorage inherently, to provide for advanced usage, a look into 
[that](http://www.reactnative.com/treat-your-data-well-with-these-react-natives-asyncstorage-wrappers/) might also prove to be helpful.

The reference code for this post can be found [here](https://github.com/yashYRS/Learning_ReactNative/tree/master/SharedPreferenceDemo). Hope this helped!!


