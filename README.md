# GDGMFFRD - Godot Engine Off-Road Game

## Software Apakah Ini?

GDGMFFRD adalah Godot Engine Off-Road Game.

## Screenshot

![ScreenShot](.readme-assets/GDGMFFRD4.png?raw=true)

![ScreenShot](.readme-assets/GDGMFFRD7.png?raw=true)

![ScreenShot](.readme-assets/GDGMFFRD8.png?raw=true)

## Cara Mencoba Kode Ini

Untuk mencoba kode ini, Anda memerlukan Godot Engine v3.4.

Download dan install software tersebut.

Kemudian buka project ini dan jalankan.

## Pendahuluan

Kali ini, saya akan memberikan contoh game off-road dengan Godot Engine.

Game ini adalah game sederhana yang bisa memilih mobil dan level.

Setelah game dimulai, mobil akan diletakkan pada level untuk mencapai finish.

Jika mobil terbalik atau jatuh maka game over.

Jika berhasil sampai finish, maka player menang.

## Cara Kerja

Untuk membuat karakter utamanya, yakni mobil, mobil di-extend dari VehicleBody dan rodanya di-extend dari VehicleWheel.

Turunan dari VehicleBody di project ini dibuat agar mobil menyerupai yang asli, walaupun masih jauh dari kenyataan.

Turunan dari VehicleWheel di project ini dibuat agar kualitas gerakan roda saat roda bersentuhan dengan obstacle lebih baik.

## Struktur Project

Untuk melihat struktur project game ini, silakan buka project ini di Godot Engine.