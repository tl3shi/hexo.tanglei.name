---
id: 161
title: 8 Useful WordPress SQL Hacks
date: 2010-12-23T04:13:02+00:00
author: tanglei
layout: post
guid: http://www.tanglei.name/?p=161
duoshuo_thread_id:
  - 1351844048792453153
categories:
  - Wordpress
tags:
  - Wordpress
---
已下内容转自<a href="http://www.smashingmagazine.com/2008/12/18/8-useful-Wordpress-sql-hacks" target="_blank">http://www.smashingmagazine.com/2008/12/18/8-useful-Wordpress-sql-hacks</a>收藏着吧，网上也有翻译版本。训练下英文阅读能力，我就转原版的。
  
**1. Creating a Backup of Your Database**
  
The problem. While the tips in the rest of this post have been tested, you should definitely not try any of them without first having a proper backup of your MySQL database.

**The solution**. To create a manual backup of your WordPress database, follow these simple steps:
  
Log in to phpMyAdmin and select your WordPress database.
  
Once done, click the “Export” button located in the horizontal menu.
  
Choose a compression method (personally, I use gzip), and click the “Execute” button.
  
Your browser will ask you if you want to download the backup. Of course, select “Yes,” and then store it on your hard drive.

**Explanation.** Note that creating a backup of your WordPress database can be more easily executed with the WP-DB-Backup plug-in. WordPress users should install this plug-in if they have not yet done so and create regular backups of their data.

**2. Batch Delete Post Revisions**

**The problem.** Post revisions, a new WordPress 2.6 feature, can be very useful, but they also increase the size of your MySQL database. Sure, you can manually delete posts revisions, but that’s very long and boring work.

**The solution.** The solution to this problem is simple: we batch delete post revisions by using a simple SQL query. The result can be almost unbelievable if you have a lot of posts: Your database size will be reduced by half!
  
Log in to phpMyAdmin and select your WordPress database.
  
Click the “SQL” button. Paste the following code in the SQL command window:1 DELETE FROM wp\_posts WHERE post\_type = &#8220;revision&#8221;;
  
1 DELETE FROM wp\_posts WHERE post\_type = &#8220;revision&#8221;;

You’re done. Depending on how many posts you had in your WordPress database, you may have saved lots of precious space!

**Code explanation.** The wp\_posts table has a field named post\_type. This field can have one of many values, such as “post,” “page” or “revision.” When we want to get rid of post revisions, we simply run a command to delete any entry in the wp\_posts table in which the post\_type field is equal to “revision.”

**3. Erase 5000 Spam Comments in a Second**

**The problem.** True story: a friend of mine recently created his own blog and started to promote it everywhere on the Internet. After some weeks of intensive work, he spent some days on vacation without Internet access.

When he came back home, he looked at his blog and saw… 5000+ comments awaiting moderation! Of course, most of them were spam, but he was actually about to check them all to make sure he did not delete a valid comment made by one of his regular readers.

**The solution.** Happily, my friend told me about his spam problem. He had already spent 45 minute manually deleting spam when I showed him this useful SQL tip.
  
Log in to phpMyAdmin and select your WordPress database.
  
Click the “SQL” button. Paste the following code in the SQL command window:

1 DELETE from wp\_comments WHERE comment\_approved = &#8216;0&#8217;;
  
1 DELETE from wp\_comments WHERE comment\_approved = &#8216;0&#8217;;

Goodbye bad comments! Enjoy your spam-free database!

**Explanation.** The wp\_comments table contains a field named comment\_approved, which is a boolean value (1 or 0). Approved comments have a value of 1, and comments awaiting moderation have a value of 0. By running the above command, we simply delete any comments that haven’t been approved yet.

Be careful. While this solution can be pretty useful if you have millions of spam comments to delete, it will also erase valid unapproved comments. If you don’t already use Akismet, install it now to prevent spamming.

**4. Change the Post Attribution**

**The problem.** When you installed WordPress, an “admin” account was created. Some bloggers make the mistake of using that account to write their posts, until they realize that it’s not personal at all.

**The solution.** Modifying author attribution on each post takes a lot of time. Happily, SQL can help you get things done:
  
Log in to your phpMyAdmin and select your WordPress database.
  
First, we have to get the right user IDs. To do so, open the SQL command window and execute the following command:1 SELECT ID, display\_name FROM wp\_users;
  
1 SELECT ID, display\_name FROM wp\_users;

phpMyAdmin will display a list of user IDs associated with WordPress users. Let’s say that NEW\_AUTHOR\_ID is the ID of the more recently created author, and OLD\_AUTHOR\_ID is the original admin account ID.
  
After you swap the NEW\_AUTHOR\_ID and OLD\_AUTHOR\_ID IDs, run the following command:1 UPDATE wp\_posts SET post\_author=NEW\_AUTHOR\_ID WHERE post\_author=OLD\_AUTHOR_ID;
  
1 UPDATE wp\_posts SET post\_author=NEW\_AUTHOR\_ID WHERE post\_author=OLD\_AUTHOR_ID;

That’s all. All posts previously attributed to admin are now attributed to whichever valid user you have selected.

**5. Manually Reset Your Password**

The problem. In order to protect their blogs, people often pick strong passwords, such as u7*KoF5i8_. Of course, this is a good thing, but I have heard many stories of forgotten admin passwords.

**The solution.** When you lose your password, WordPress can email you a link to reset it. But if you don’t have access to the email address recorded in the WordPress database anymore, or if you prefer just running a simple command instead, here is the hack.
  
Log in to your phpMyAdmin, select your WordPress database and open the SQL window.
  
Insert the following command (assuming your username is “admin”):1 UPDATE \`wp\_users\` SET \`user\_pass\` = MD5(&#8216;PASSWORD&#8217;) WHERE \`wp\_users\`.\`user\_login\` =\`admin\` LIMIT 1;
  
1 UPDATE \`wp\_users\` SET \`user\_pass\` = MD5(&#8216;PASSWORD&#8217;) WHERE \`wp\_users\`.\`user\_login\` =\`admin\` LIMIT 1;

You’re done. Your password has been successfully replaced by whatever you inserted in space above marked “PASSWORD.”

**Explanation.** User passwords are stored in the wp_users table. Of course, an MD5 hash is used to secure the password.

We have to set up an “UPDATE” SQL request and use the built-in MD5() MySQL function to convert our password to MD5 and then update it. The “WHERE” clause ensures that we’re updating only the admin’s password. The same request without the “WHERE” clause would result in all passwords being updated!

**6. Change Your WordPress Domain Name**

The problem. Although it is not recommended, you may want at some point to change your domain name while keeping your blog and its data. Because WordPress records your domain name in the database, you have to change the database in order to connect your new domain name to your WordPress blog.

**The solution.**
  
You guessed it: the first thing to do is log in to your phpMyAdmin and select your WordPress database.
  
Click the “SQL” button to open the SQL command window. In order to change your WordPress URL, execute this first command:1 UPDATE wp\_options SET option\_value = replace(option\_value, &#8216;http://www.oldsite.com&#8217;, &#8216;http://www.newsite.com&#8217;) WHERE option\_name = &#8216;home&#8217; OR option_name = &#8216;siteurl&#8217;;
  
1 UPDATE wp\_options SET option\_value = replace(option\_value, &#8216;http://www.oldsite.com&#8217;, &#8216;http://www.newsite.com&#8217;) WHERE option\_name = &#8216;home&#8217; OR option_name = &#8216;siteurl&#8217;;

Then, we have to replace the relative URL (guid) of each post. The following command will do that job:1 UPDATE wp_posts SET guid = replace(guid, &#8216;http://www.oldsite.com&#8217;,&#8217;http://www.newsite.com&#8217;);
  
1 UPDATE wp_posts SET guid = replace(guid, &#8216;http://www.oldsite.com&#8217;,&#8217;http://www.newsite.com&#8217;);

We’re almost done. The last thing to do is a search and replace in the wp\_posts table to make sure that no absolute URL is still here:1 UPDATE wp\_posts SET post\_content = replace(post\_content, &#8216;http://www.oldsite.com&#8217;, &#8216;http://www.newsite.com&#8217;);
  
1 UPDATE wp\_posts SET post\_content = replace(post_content, &#8216;http://www.oldsite.com&#8217;, &#8216;http://www.newsite.com&#8217;);

You’re done. You should be able to log in to your WordPress dashboard using your new URL.

**Explanation.** To easily change our WordPress domain name, I took advantage of the super-useful MySQL function “replace,” which allows you to replace one term by another.

**7. Display the Number of SQL Queries on Your blog**

**The problem.** When trying to optimize your blog’s loading time, knowing the number of queries made to the database is important. In order to reduce queries, the first thing to know is how many queries are made on a single page.

**The solution.**
  
This time, no need to log in to phpMyAdmin. Simply open the footer.php file in your theme and append the following lines of code:1 <?php if (is\_user\_logged_in()) { ?>
  
2     <?php echo get\_num\_queries(); ?> queries in <?php timer_stop(1); ?> seconds.
  
3 <?php } ?>
  
1 <?php if (is\_user\_logged_in()) { ?>
  
2     <?php echo get\_num\_queries(); ?> queries in <?php timer_stop(1); ?> seconds.
  
3 <?php } ?>

Save the file and visit your blog. In the footer, you’ll see the number of queries made to the WordPress database as well as the time it took to make them.

**Explanation.** Seems that many WordPress users aren’t aware of this useful function. The get\_num\_queries() function returns the number of executed queries during a page load.

Note that the above code will only display the number of queries to logged-in users, because regular visitors and search engine bots don’t need to know about it. But, if you’d like to make it public, simply remove the if (is\_user\_logged_in()) conditional instruction.

**8. Restore Your WordPress Database**

The problem. Let’s say, for some reason, such as a hacking or upgrade problem, you have lost your blog data or it has become corrupted. If you have a backup (and I hope you do!) you will have to import it to your WordPress database.

**The solution.**
  
Log in to phpMyAdmin and select your WordPress database.
  
Click the “Import” button in the horizontal menu.
  
Click the “Browse” button and select the most recent database backup on your hard disk.
  
Click the “Execute” button. If everything went well, your WordPress database is fully functional again.
