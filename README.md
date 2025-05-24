````markdown
# PostgreSQL Assignment - Wildlife Conservation Monitoring

---

### 1. What is PostgreSQL?  
**PostgreSQL** হলো একটি **উন্নত ও ওপেন সোর্স রিলেশনাল ডেটাবেস ম্যানেজমেন্ট সিস্টেম (RDBMS)**, যা Data store, manage করার জন্য ব্যবহার করা হয়। এটি শক্তিশালী, নিরাপদ এবং বড় বড় অ্যাপ্লিকেশনের জন্য উপযুক্ত।

---

### 2. Explain the Primary Key and Foreign Key concepts in PostgreSQL.  
**Primary Key** হলো এমন একটি কলাম যা প্রতিটি সারিকে **এককভাবে (unique)** চিহ্নিত করে।

**বৈশিষ্ট্য:**  
- মান অবশ্যই **ইউনিক** হতে হবে  
- কখনোই **NULL** হতে পারবে না  
- একটি টেবিলে কেবল **একটি** Primary Key থাকতে পারে

**উদাহরণ:**  
```sql
CREATE TABLE rangers (
  ranger_id SERIAL PRIMARY KEY,
  name TEXT,
  region TEXT
);
````

এখানে `ranger_id` হলো Primary Key — প্রতিটি রেঞ্জারের একটি আলাদা আইডি থাকবে।

---

## Foreign Key (ফরেন কি)

**Foreign Key** এমন একটি কলাম যা অন্য একটি টেবিলের Primary Key-কে **reference** করে। এটি দুইটি টেবিলের মধ্যে **সম্পর্ক** তৈরি করে।

**বৈশিষ্ট্য:**

* অন্য টেবিলের Primary Key-এর মানকে অনুসরণ করে
* ডেটার মধ্যে **referential integrity** নিশ্চিত করে
* দুটি টেবিলকে যুক্ত করে

**উদাহরণ:**

```sql
CREATE TABLE sightings (
  sighting_id SERIAL PRIMARY KEY,
  ranger_id INT REFERENCES rangers(ranger_id),
  species_id INT,
  sighting_time TIMESTAMP,
  location TEXT
);
```

এখানে `ranger_id` হলো একটি **Foreign Key**, যা `rangers` টেবিলের `ranger_id` এর সাথে যুক্ত। অর্থাৎ, প্রতিটি sighting কে অবশ্যই একটি বিদ্যমান রেঞ্জারের সাথে যুক্ত থাকতে হবে।

---

### 3. What is the difference between the VARCHAR and CHAR data types?

**VARCHAR** এবং **CHAR** উভয়ই টেক্সট ডেটা সংরক্ষণ করতে ব্যবহৃত হয়, তবে এদের মূল পার্থক্য হলো কে কতোটুকু স্টোরেজ দখল করে। `CHAR(n)` একটি ডেটা টাইপ, যেখানে ফিক্সড দৈর্ঘ্যের স্টোরেজ হয় এবং ছোট ডেটার শেষে স্বয়ংক্রিয়ভাবে ফাঁকা জায়গা যোগ করা হয়। অন্যদিকে, `VARCHAR(n)` একটি **পরিবর্তনশীল দৈর্ঘ্যের** ডেটা টাইপ, যা যতটুকু জায়গা দরকার ততটুকুই ব্যবহার করে এবং বাড়তি স্পেস সংরক্ষণ করে না।

---

### 4. Explain the purpose of the WHERE clause in a SELECT statement.

**WHERE** ক্লজ ব্যবহার করা হয় **SELECT** স্টেটমেন্টে **শর্ত নির্ধারণের জন্য**, যেন কেবল নির্দিষ্ট শর্ত পূরণ করা সারিগুলোই রিটার্ন হয়।

**WHERE ক্লজ** ব্যবহার করে ডেটাবেস থেকে **নির্বাচিত ডেটা ফিল্টার** করা যায়।
উদাহরণ:

```sql
SELECT * FROM rangers WHERE region = 'River Delta';
```

এটি শুধুমাত্র 'River Delta' অঞ্চল থাকা রেঞ্জারদের ডেটা দেখাবে।

---

### 5. Explain the GROUP BY clause and its role in aggregation operations.

**GROUP BY** ক্লজ ব্যবহার করা হয় ডেটাকে একটি বা একাধিক কলামের ভিত্তিতে **গ্রুপ করার জন্য**, যাতে **aggregation** (যেমন COUNT, SUM, AVG) প্রয়োগ করা যায় প্রতিটি গ্রুপে আলাদা করে।

**GROUP BY** ডেটাকে ভাগ করে এবং প্রতিটি ভাগে count বা sum ইত্যাদি বের করতে সাহায্য করে।
উদাহরণ:

```sql
SELECT region, COUNT(*) FROM rangers GROUP BY region;
```

এটি প্রতিটি অঞ্চলের রেঞ্জারদের সংখ্যা দেখাবে।

```
```
