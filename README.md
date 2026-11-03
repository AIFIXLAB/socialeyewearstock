# Social Eyewear บัญชีร้าน

แอปบันทึกการขาย สินค้า รายรับ-รายจ่าย ปฏิทิน และสรุปกำไรของร้าน เป็นเว็บแบบ static ไม่ต้อง build

## 1. ตั้งค่าฐานข้อมูล

1. สร้างโปรเจกต์ใน Supabase
2. รัน `supabase/schema.sql` ทั้งไฟล์ใน SQL Editor
3. ใส่ Project URL และ publishable key ใน `config.js`

ห้ามใส่ secret หรือ `service_role` key ใน `config.js`

## 2. อัปขึ้น GitHub

สร้าง repository แบบ Private แล้วอัปไฟล์ในโฟลเดอร์นี้ โดยให้ `index.html` อยู่ชั้นบนสุด

## 3. ลง Vercel

Add New > Project > เลือก repository > Framework Preset เลือก **Other** > Deploy

## รหัสเข้าโปรแกรม

เข้าโปรแกรมด้วยรหัส 4 หลักอย่างเดียว ฐานข้อมูลเป็นคนตรวจ ใส่ผิด 5 ครั้งติดกันจะล็อกทุกเครื่อง 30 นาที

เปลี่ยนรหัส: แก้เลขในบรรทัดล่างสุดของ `supabase/schema.sql` แล้วรันใหม่ ข้อมูลร้านไม่หาย

ถ้าคนนอกกดรหัสผิดซ้ำ ๆ ร้านจะเข้าไม่ได้ระหว่างล็อก ปลดล็อกทันทีได้ด้วยการรัน `update public.app_pin set fails = 0, locked_until = null;` ใน SQL Editor
