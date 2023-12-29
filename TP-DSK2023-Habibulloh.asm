.model small
.stack 100h

.data
    angka db 10 dup('$')  
    pesanPrima db " adalah bilangan prima.", '$'
    pesanBukanPrima db " bukan bilangan prima.", '$'
    newline db 0dh, 0ah, '$' 

.code
    main proc
        mov ax, @data
        mov ds, ax

        ; memasukkan angka
        mov ah, 0Ah       
        lea dx, angka     
        int 21h           

        
        mov si, offset angka + 2 
        mov cx, 0         

    hitungPanjang:
        mov al, [si]     
        cmp al, '$'      
        je  selesaiPanjang  ; Jika ya, keluar dari loop

        inc cx           
        inc si           
        jmp hitungPanjang   ; Lanjutkan loop

    selesaiPanjang:
        mov di, offset angka + 2 + cx - 1 

        
        xor ax, ax       
        mov bx, 1        
        mov dx, 0        

    konversiKeBilangan:
        mov al, [di]     
        sub al, 30h      
        mul bx           
        add ax, dx       
        mov dx, 0        
        mov bl, 10       
        div bl           
        dec di           

        cmp di, offset angka + 2 - 1  
        jae konversiKeBilangan  

        

        cmp al, 1         
        jbe bukanPrima    

        mov bl, 2         
        call cekPrima     

        cmp bl, 1         
        je  bilanganPrima    
        jmp bukanPrima       

    bilanganPrima:
        mov ah, 09h      
        lea dx, pesanPrima
        int 21h

        jmp selesai       

    bukanPrima:
        mov ah, 09h      
        lea dx, pesanBukanPrima
        int 21h

    selesai:
        mov ah, 09h      
        lea dx, newline
        int 21h

        mov ah, 4ch      
        int 21h

    cekPrima proc
        xor bh, bh       

    cekLoop:
        mov ah, 0       
        div bl           
        cmp ah, 0        
        je  notPrime     
        inc bl           
        cmp bl, al       
        jg  isPrime      
        jmp cekLoop      

    notPrime:
        mov bl, 0        
        ret

    isPrime:
        mov bl, 1        
        ret

    cekPrima endp

    end main
