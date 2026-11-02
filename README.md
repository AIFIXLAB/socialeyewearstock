# Social Eyewear บัญชีร้าน

แอปบันทึกการขาย สินค้า รายรับ-รายจ่าย ปฏิทิน และสรุปกำไรของร้าน เป็นเว็บแบบ static ไม่ต้อง build

## 1. สร้างฐานข้อมูล (ทำก่อนใช้จริง)

1. สร้างโปรเจกต์ใหม่ใน Supabase แยกจากระบบหลักของร้าน
2. เปิด `supabase/schema.sql` แก้ `your-email@example.com` เป็นอีเมลของคุณ แล้วรันใน SQL Editor
3. ไปที่ Authentication > Users > Add user สร้างผู้ใช้ด้วยอีเมลเดียวกันพร้อมรหัสผ่าน
4. ไปที่ Project Settings > API คัดลอก Project URL และ anon public key มาใส่ใน `config.js`

ห้ามใส่ `service_role` key ใน `config.js` เพราะไฟล์นี้เปิดอ่านได้จากเว็บ ส่วน anon key เปิดเผยได้ เพราะข้อมูลถูกกันด้วยการล็อกอินและรายชื่อใน `app_members`

เพิ่มพนักงาน: สร้างผู้ใช้ใน Authentication แล้วรัน `insert into public.app_members (email) values ('อีเมลพนักงาน');`

## 2. อัปขึ้น GitHub

สร้าง repository แบบ Private แล้วอัปไฟล์ทั้งหมดในโฟลเดอร์นี้ โดยให้ `index.html` อยู่ชั้นบนสุดของ repository

## 3. ลง Vercel

Add New > Project > เลือก repository > Framework Preset เลือก **Other** > ไม่ต้องตั้ง Build Command > Deploy

ถ้า `config.js` ยังว่าง แอปจะเก็บข้อมูลในเบราว์เซอร์เครื่องนั้นเท่านั้น ใช้ทดลองได้ แต่ไม่ควรใช้จริง
