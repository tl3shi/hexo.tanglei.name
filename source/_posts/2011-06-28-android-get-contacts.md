---
id: 944
title: android获取联系人代码
date: 2011-06-28T16:34:38+00:00
author: tanglei
layout: post
guid: http://www.tanglei.name/?p=944
duoshuo_thread_id:
  - 1351844048792453434
enable_highlight:
  - '<link rel="stylesheet" href="../wp-content/blogresources/highlightconfig/highlight.default.min.css"><script src="../wp-content/blogresources/highlightconfig/jquery-2.1.4.min.js"></script><script src="../wp-content/blogresources/highlightconfig/enable_highlight.js"></script>'
categories:
  - coding小工具
tags:
---
前面讲的发送短信就这样吧。能发就行了。不考虑啥性能效率的问题的话，就一个for循环就群发了。至于我想象当中的定制的消息的话，就是获取联系人，匹配短信模版，正则替换得到定制的独一无二的短信。现在就是要获取联系人。最简单的方法就是如下

```java
public class SimpleContact extends ListActivity
{

	/* 
	 * @see android.app.Activity#onCreate(android.os.Bundle)
	 */
	@Override
	protected void onCreate(Bundle savedInstanceState)
	{
		super.onCreate(savedInstanceState);
		getContacts();
	}
	
	/**
	 * Author: tl3shi
	 * 下午12:14:35
	 * Discription:
	 */
	private void getContacts()
	{
		// Get a cursor with all people
		Cursor c = getContentResolver().query(ContactsContract.CommonDataKinds.Phone.CONTENT_URI, null, 
				null, null, 
				null);
		
		startManagingCursor(c);
		ListAdapter adapter = new SimpleCursorAdapter(this, 
		        android.R.layout.simple_list_item_2, 
		        c, 
		        new String[] {PhoneLookup.DISPLAY_NAME,PhoneLookup._ID} ,
		        new int[] {android.R.id.text1,android.R.id.text2}); 
		setListAdapter(adapter);
	}

}
```

效果如下[<img src="/wp-content/uploads/2011/06/android-get-contact.jpg" alt="android获取通讯录" title="android获取联系人"  class="aligncenter size-full wp-image-945" />](/wp-content/uploads/2011/06/android-get-contact.jpg)
  
原以为想到，直接将显示的每一个item小的那个字段直接搞成电话号码就行了。现在看来我为啥会那样想呢。。自己手机里的一个联系人有2个电话也是常有的事情啊，那得现实哪个？所以报错啊之类就很正常了。
  
看看query方法的签名：

```java
public final Cursor query (Uri uri, String[] projection, String selection, String[] selectionArgs, String sortOrder) 
```

API如下解释

Query the given URI, returning a Cursor over the result set. 

For best performance, the caller should follow these guidelines: 

Provide an explicit projection, to prevent reading data from storage that aren&#8217;t going to be used. 

Use question mark parameter markers such as &#8216;phone=?&#8217; instead of explicit values in the selection parameter, so that queries that differ only by those values will be recognized as the same for caching purposes. 

Parameters
  
**uri ：** The URI, using the content:// scheme, for the content to retrieve.
  
**projection** A list of which columns to return. Passing null will return all columns, which is inefficient.
  
**selection** A filter declaring which rows to return, formatted as an SQL WHERE clause (excluding the WHERE itself). Passing null will return all rows for the given URI.
  
**selectionArgs** You may include ?s in selection, which will be replaced by the values from selectionArgs, in the order that they appear in the selection. The values will be bound as Strings.
  
**sortOrder** How to order the rows, formatted as an SQL ORDER BY clause (excluding the ORDER BY itself). Passing null will use the default sort order, which may be unordered. 

Returns
  
A Cursor object, which is positioned before the first entry, or null
  
看来我的直接通过那样来获取每个联系人姓名及其手机号码的梦想是泡汤了。还得这样做才行。 

```java
public void getContact(){   
     //获得所有的联系人   
    Cursor cur = getContentResolver().query(ContactsContract.Contacts.CONTENT_URI, null, null, null, null);   
    //循环遍历   
    if (cur.moveToFirst()) {   
        int idColumn  = cur.getColumnIndex(ContactsContract.Contacts._ID);   
           
        int displayNameColumn = cur.getColumnIndex(ContactsContract.Contacts.DISPLAY_NAME);   
        do {   
            //获得联系人的ID号   
           String contactId = cur.getString(idColumn);   
           //获得联系人姓名   
           String disPlayName = cur.getString(displayNameColumn);   
           //查看该联系人有多少个电话号码。如果没有这返回值为0   
           int phoneCount = cur.getInt(cur   
                    .getColumnIndex(ContactsContract.Contacts.HAS_PHONE_NUMBER));   
           if(phoneCount>0){   
               //获得联系人的电话号码   
               Cursor phones = getContentResolver().query(   
                        ContactsContract.CommonDataKinds.Phone.CONTENT_URI,   
                        null,   
                        ContactsContract.CommonDataKinds.Phone.CONTACT_ID   
                                + " = " + contactId, null, null);   
               if(phones.moveToFirst()){   
                   do{   
                       //遍历所有的电话号码   
                       String phoneNumber= phones.getString(phones     
                                .getColumnIndex(ContactsContract.CommonDataKinds.Phone.NUMBER));   
                       System.out.println(phoneNumber);   
                   }while(phones.moveToNext());   
               }   
              
           }   
  
           } while (cur.moveToNext());   
  
    }   
    }
```

若只想要得到手机号码，在第3个参数上面也说了，加where条件即可。

```java
Cursor phones = mContext.getContentResolver().query(
                                ContactsContract.CommonDataKinds.Phone.CONTENT_URI,
                                null,
                                ContactsContract.CommonDataKinds.Phone.CONTACT_ID
                                                + " = " + contactId +" and "+ContactsContract.CommonDataKinds.Phone.TYPE+"="+ContactsContract.CommonDataKinds.Phone.TYPE_MOBILE, null, null);
```
