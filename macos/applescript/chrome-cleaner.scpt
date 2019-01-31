FasdUAS 1.101.10   ��   ��    k             l      ��  ��   �� 
Exports all Google Chrome tabs to a CSV file. 

NOTE TO PATRICK::: copy source from the .dotfiles/macos/applescript/chrome-cleaner.scpt

This is used in my system alongside a Hazel rule that automatically
moves and renames the CSV file when placed on the Desktop.
	
// Originally inspired by 
Francesco Di Lorenzo (@frankdilo)

// Changed to suit my needs on 
Patrick Ward (@patrickward), January 30, 2019

     � 	 	2   
 E x p o r t s   a l l   G o o g l e   C h r o m e   t a b s   t o   a   C S V   f i l e .   
 
 N O T E   T O   P A T R I C K : : :   c o p y   s o u r c e   f r o m   t h e   . d o t f i l e s / m a c o s / a p p l e s c r i p t / c h r o m e - c l e a n e r . s c p t 
 
 T h i s   i s   u s e d   i n   m y   s y s t e m   a l o n g s i d e   a   H a z e l   r u l e   t h a t   a u t o m a t i c a l l y 
 m o v e s   a n d   r e n a m e s   t h e   C S V   f i l e   w h e n   p l a c e d   o n   t h e   D e s k t o p . 
 	 
 / /   O r i g i n a l l y   i n s p i r e d   b y   
 F r a n c e s c o   D i   L o r e n z o   ( @ f r a n k d i l o ) 
 
 / /   C h a n g e d   t o   s u i t   m y   n e e d s   o n   
 P a t r i c k   W a r d   ( @ p a t r i c k w a r d ) ,   J a n u a r y   3 0 ,   2 0 1 9 
 
   
  
 l     ��������  ��  ��        j     �� �� 0 reporttitle reportTitle  m        �    C h r o m e   T a b s      l     ��������  ��  ��        i        I      �� ���� 0 quotecsv quoteCSV   ��  o      ���� 0 _string  ��  ��    k            r         m        �    "  o      ���� 0 dq      ��   L     ! ! b     " # " b     $ % $ o    ���� 0 dq   % n    & ' & I    �� (���� 0 replace   (  ) * ) o    ���� 0 _string   *  + , + o    ���� 0 dq   ,  -�� - b     . / . o    	���� 0 dq   / o   	 
���� 0 dq  ��  ��   '  f     # o    ���� 0 dq  ��     0 1 0 l     ��������  ��  ��   1  2 3 2 i    
 4 5 4 I      �� 6���� 0 replace   6  7 8 7 o      ���� 0 _string   8  9 : 9 o      ���� 0 _source   :  ;�� ; o      ���� 0 _replacement  ��  ��   5 k      < <  = > = r      ? @ ? o     ���� 0 _source   @ n      A B A 1    ��
�� 
txdl B 1    ��
�� 
ascr >  C D C r     E F E n    	 G H G 2    	��
�� 
citm H o    ���� 0 _string   F o      ���� 
0 _items   D  I J I r     K L K o    ���� 0 _replacement   L n      M N M 1    ��
�� 
txdl N 1    ��
�� 
ascr J  O�� O L     P P c     Q R Q o    ���� 
0 _items   R m    ��
�� 
ctxt��   3  S T S l     ��������  ��  ��   T  U V U i     W X W I      �� Y���� 0 join   Y  Z [ Z o      ���� 	0 _list   [  \�� \ o      ���� 0 _sep  ��  ��   X k      ] ]  ^ _ ^ r      ` a ` n     b c b 1    ��
�� 
txdl c 1     ��
�� 
ascr a o      ���� 	0 _temp   _  d e d r     f g f o    ���� 0 _sep   g n      h i h 1    
��
�� 
txdl i 1    ��
�� 
ascr e  j k j r     l m l c     n o n o    ���� 	0 _list   o m    ��
�� 
utxt m o      ���� 0 _result   k  p q p r     r s r o    ���� 	0 _temp   s n      t u t 1    ��
�� 
txdl u 1    ��
�� 
ascr q  v�� v L     w w o    ���� 0 _result  ��   V  x y x l     ��������  ��  ��   y  z { z l     |���� | r      } ~ } I    �� ��
�� .sysontocTEXT       shor  m     ���� 
��   ~ 1      ��
�� 
lnfd��  ��   {  � � � l    ����� � r     � � � l    ����� � c     � � � l    ����� � l    ����� � I   ������
�� .misccurdldt    ��� null��  ��  ��  ��  ��  ��   � m    ��
�� 
TEXT��  ��   � l      ����� � o      ���� 0 	datestamp 	dateStamp��  ��  ��  ��   �  � � � l   $ ����� � r    $ � � � b    " � � � I     �� ����� 0 quotecsv quoteCSV �  ��� � b     � � � b     � � � o    ���� 0 reporttitle reportTitle � m     � � � � � 
   f o r   � l    ����� � o    ���� 0 	datestamp 	dateStamp��  ��  ��  ��   � m     ! � � � � �  ,   U R L S � o      ���� 0 	notetitle 	noteTitle��  ��   �  � � � l  % * ����� � r   % * � � � J   % ( � �  ��� � o   % &���� 0 	notetitle 	noteTitle��   � o      ���� 0 urllist urlList��  ��   �  � � � l     ��������  ��  ��   �  � � � l  + 4 ����� � I  + 4���� �
�� .sysonotfnull��� ��� TEXT��   � �� � �
�� 
appr � m   - . � � � � � $ G e n e r a t i n g   t a b s . . . � �� ���
�� 
subt � o   / 0���� 0 	notetitle 	noteTitle��  ��  ��   �  � � � l  5 � ����� � O   5 � � � � k   ; � � �  � � � I  ; @������
�� .miscactvnull��� ��� null��  ��   �  ��� � X   A � ��� � � Q   Y � � � � � X   \ � ��� � � k   t � � �  � � � r   t z � � � J   t v����   � o      ���� 0 tablist tabList �  � � � s   { � � � � n  { � � � � I   | ��� ���� 0 quotecsv quoteCSV �  ��~ � n   | � � � � 1   } ��}
�} 
pnam � o   | }�|�| 0 thetab theTab�~  �   �  f   { | � l      ��{�z � n       � � �  ;   � � � o   � ��y�y 0 tablist tabList�{  �z   �  � � � s   � � � � � n  � � � � � I   � ��x ��w�x 0 quotecsv quoteCSV �  ��v � n   � � � � � 1   � ��u
�u 
URL  � o   � ��t�t 0 thetab theTab�v  �w   �  f   � � � l      ��s�r � n       � � �  ;   � � � o   � ��q�q 0 tablist tabList�s  �r   �  � � � l  � ��p � ��p   � 0 * set tabTitle to (title of theTab) as text    � � � � T   s e t   t a b T i t l e   t o   ( t i t l e   o f   t h e T a b )   a s   t e x t �  � � � l  � ��o�n�m�o  �n  �m   �  � � � l  � ��l � ��l   � G A Note the use of "my" is required because we're in the namespace     � � � � �   N o t e   t h e   u s e   o f   " m y "   i s   r e q u i r e d   b e c a u s e   w e ' r e   i n   t h e   n a m e s p a c e   �  � � � l  � ��k � ��k   � ] W of Google Chrome at this point and "my" tells the script to use "my" quoteCSV function    � � � � �   o f   G o o g l e   C h r o m e   a t   t h i s   p o i n t   a n d   " m y "   t e l l s   t h e   s c r i p t   t o   u s e   " m y "   q u o t e C S V   f u n c t i o n �  � � � l  � ��j � ��j   � M G set tabInfo to "" & my quoteCSV(tabTitle) & ", " & my quoteCSV(tabUrl)    � � � � �   s e t   t a b I n f o   t o   " "   &   m y   q u o t e C S V ( t a b T i t l e )   &   " ,   "   &   m y   q u o t e C S V ( t a b U r l ) �  � � � s   � � � � � n  � � � � � I   � ��i ��h�i 0 join   �  � � � o   � ��g�g 0 tablist tabList �  ��f � m   � � � � � � �  ,�f  �h   �  f   � � � l      �e�d  n        ;   � � o   � ��c�c 0 urllist urlList�e  �d   � �b l  � ��a�a   ) # copy tabInfo to the end of urlList    � F   c o p y   t a b I n f o   t o   t h e   e n d   o f   u r l L i s t�b  �� 0 thetab theTab � l  _ d�`�_ n   _ d	 2  ` d�^
�^ 
CrTb	 o   _ `�]�] 0 	thewindow 	theWindow�`  �_   � R      �\
�[
�\ .ascrerr ****      � ****
 o      �Z�Z 0 errormsg errorMsg�[   � k   � �  I  � ��Y�X
�Y .ascrcmnt****      � **** b   � � m   � � � 0 E r r o r   ( c h r o m e - c l e a n e r ) :   o   � ��W�W 0 errormsg errorMsg�X   �V I  � ��U�T
�U .sysonotfnull��� ��� TEXT�T   �S
�S 
appr m   � � � , E R R O R   ( c h r o m e - c l e a n e r ) �R�Q
�R 
subt o   � ��P�P 0 errormsg errorMsg�Q  �V  �� 0 	thewindow 	theWindow � 2  D I�O
�O 
cwin��   � m   5 8�                                                                                  rimZ  alis    >  Macintosh HD                   BD ����Google Chrome.app                                              ����            ����  
 cu             Applications  !/:Applications:Google Chrome.app/   $  G o o g l e   C h r o m e . a p p    M a c i n t o s h   H D  Applications/Google Chrome.app  / ��  ��  ��   �  l     �N�M�L�N  �M  �L    l     �K �K     Convert list to text      �!! ,   C o n v e r t   l i s t   t o   t e x t   "#" l  � �$�J�I$ r   � �%&% n  � �'(' 1   � ��H
�H 
txdl( 1   � ��G
�G 
ascr& o      �F�F 0 olddelim oldDelim�J  �I  # )*) l  � �+�E�D+ r   � �,-, 1   � ��C
�C 
lnfd- n     ./. 1   � ��B
�B 
txdl/ 1   � ��A
�A 
ascr�E  �D  * 010 l  � �2�@�?2 r   � �343 c   � �565 l  � �7�>�=7 o   � ��<�< 0 urllist urlList�>  �=  6 m   � ��;
�; 
ctxt4 o      �:�: 0 urllist urlList�@  �?  1 898 l  � �:�9�8: r   � �;<; o   � ��7�7 0 olddelim oldDelim< n     =>= 1   � ��6
�6 
txdl> 1   � ��5
�5 
ascr�9  �8  9 ?@? l     �4�3�2�4  �3  �2  @ ABA l     �1CD�1  C "  Choose the export file name   D �EE 8   C h o o s e   t h e   e x p o r t   f i l e   n a m eB FGF l     �0HI�0  H S M (wrapping in a finder function so that the dialog works in Alfred, KM, etc.)   I �JJ �   ( w r a p p i n g   i n   a   f i n d e r   f u n c t i o n   s o   t h a t   t h e   d i a l o g   w o r k s   i n   A l f r e d ,   K M ,   e t c . )G KLK l  �2M�/�.M O   �2NON k  1PP QRQ I 	�-�,�+
�- .miscactvnull��� ��� null�,  �+  R S�*S r  
1TUT I 
-�)�(V
�) .sysonwflfile    ��� null�(  V �'WX
�' 
prmtW m  YY �ZZ  N a m e   t h i s   f i l e :X �&[\
�& 
dfnm[ b  ]^] o  �%�% 0 reporttitle reportTitle^ l 	_�$�#_ m  `` �aa  . c s v�$  �#  \ �"b�!
�" 
dflcb l  'c� �c I  '�d�
� .earsffdralis        afdrd m   #�
� afdmdesk�  �   �  �!  U o      �� 0 savefile saveFile�*  O m   �ee�                                                                                  MACS  alis    @  Macintosh HD                   BD ����
Finder.app                                                     ����            ����  
 cu             CoreServices  )/:System:Library:CoreServices:Finder.app/    
 F i n d e r . a p p    M a c i n t o s h   H D  &System/Library/CoreServices/Finder.app  / ��  �/  �.  L fgf l     ����  �  �  g hih l     �jk�  j   Write the file    k �ll     W r i t e   t h e   f i l e  i mnm l 3io��o O  3ipqp k  9hrr sts r  9Huvu I 9D�wx
� .rdwropenshor       filew o  9<�� 0 savefile saveFilex �y�
� 
permy m  ?@�
� boovtrue�  v o      �� 0 savefiel saveFielt z{z Q  I`|}�| I LW�~
� .rdwrwritnull���     ****~ o  LM�� 0 urllist urlList ���

� 
refn� o  PS�	�	 0 savefile saveFile�
  } R      ���
� .ascrerr ****      � ****�  �  �  { ��� I ah���
� .rdwrclosnull���     ****� o  ad�� 0 savefile saveFile�  �  q m  36���                                                                                  sevs  alis    \  Macintosh HD                   BD ����System Events.app                                              ����            ����  
 cu             CoreServices  0/:System:Library:CoreServices:System Events.app/  $  S y s t e m   E v e n t s . a p p    M a c i n t o s h   H D  -System/Library/CoreServices/System Events.app   / ��  �  �  n ��� l     �� ���  �   ��  � ��� l     ������  �   Finally close all tabs   � ��� .   F i n a l l y   c l o s e   a l l   t a b s� ��� l j������� O  j���� k  p��� ��� X  p������ Q  ������ X  ������� I �������
�� .coreclosnull���     obj � o  ������ 0 thetab theTab��  �� 0 thetab theTab� l �������� n  ����� 2 ����
�� 
CrTb� o  ������ 0 	thewindow 	theWindow��  ��  � R      �����
�� .ascrerr ****      � ****� o      ���� 0 errormsg errorMsg��  � k  ���� ��� I �������
�� .ascrcmnt****      � ****� b  ����� m  ���� ��� 0 E r r o r   ( c h r o m e - c l e a n e r ) :  � o  ������ 0 errormsg errorMsg��  � ��� I �������
�� .sysonotfnull��� ��� TEXT��  � ����
�� 
appr� m  ���� ��� , E R R O R   ( c h r o m e - c l e a n e r )� �����
�� 
subt� o  ������ 0 errormsg errorMsg��  � ����  S  ����  �� 0 	thewindow 	theWindow� 2 sx��
�� 
cwin� ���� I ��������
�� .aevtquitnull��� ��� null��  ��  ��  � m  jm���                                                                                  rimZ  alis    >  Macintosh HD                   BD ����Google Chrome.app                                              ����            ����  
 cu             Applications  !/:Applications:Google Chrome.app/   $  G o o g l e   C h r o m e . a p p    M a c i n t o s h   H D  Applications/Google Chrome.app  / ��  ��  ��  � ��� l     ��������  ��  ��  � ��� l     ��������  ��  ��  � ��� l     ��������  ��  ��  � ��� l     ��������  ��  ��  � ���� l     ��������  ��  ��  ��       ��� ������  � ������������ 0 reporttitle reportTitle�� 0 quotecsv quoteCSV�� 0 replace  �� 0 join  
�� .aevtoappnull  �   � ****� �� ���������� 0 quotecsv quoteCSV�� ����� �  ���� 0 _string  ��  � ������ 0 _string  �� 0 dq  �  ���� 0 replace  �� �E�O�)����%m+ %�%� �� 5���������� 0 replace  �� ����� �  �������� 0 _string  �� 0 _source  �� 0 _replacement  ��  � ���������� 0 _string  �� 0 _source  �� 0 _replacement  �� 
0 _items  � ��������
�� 
ascr
�� 
txdl
�� 
citm
�� 
ctxt�� ���,FO��-E�O���,FO��&� �� X���������� 0 join  �� ����� �  ������ 	0 _list  �� 0 _sep  ��  � ���������� 	0 _list  �� 0 _sep  �� 	0 _temp  �� 0 _result  � ������
�� 
ascr
�� 
txdl
�� 
utxt�� ��,E�O���,FO��&E�O���,FO�� �����������
�� .aevtoappnull  �   � ****� k    ���  z��  ���  ���  ���  ���  ��� "�� )�� 0�� 8�� K�� m�� �����  ��  ��  � �������� 0 	thewindow 	theWindow�� 0 thetab theTab�� 0 errormsg errorMsg� <������������ ��� ������� ������������������������� ���������������~e�}Y�|`�{�z�y�x�w�v��u�t�s�r�q�p�o�n���m�� 

�� .sysontocTEXT       shor
�� 
lnfd
�� .misccurdldt    ��� null
�� 
TEXT�� 0 	datestamp 	dateStamp�� 0 quotecsv quoteCSV�� 0 	notetitle 	noteTitle�� 0 urllist urlList
�� 
appr
�� 
subt�� 
�� .sysonotfnull��� ��� TEXT
�� .miscactvnull��� ��� null
�� 
cwin
�� 
kocl
�� 
cobj
�� .corecnte****       ****
�� 
CrTb�� 0 tablist tabList
�� 
pnam
�� 
URL �� 0 join  �� 0 errormsg errorMsg��  
�� .ascrcmnt****      � ****
�� 
ascr
�� 
txdl� 0 olddelim oldDelim
�~ 
ctxt
�} 
prmt
�| 
dfnm
�{ 
dflc
�z afdmdesk
�y .earsffdralis        afdr�x 
�w .sysonwflfile    ��� null�v 0 savefile saveFile
�u 
perm
�t .rdwropenshor       file�s 0 savefiel saveFiel
�r 
refn
�q .rdwrwritnull���     ****�p  
�o .rdwrclosnull���     ****
�n .coreclosnull���     obj 
�m .aevtquitnull��� ��� null����j E�O*j �&E�O*b   �%�%k+ �%E�O�kvE�O*����� Oa  �*j O �*a -[a a l kh   Y S�a -[a a l kh jvE` O)�a ,k+ _ 6GO)�a ,k+ _ 6GO)_ a l+ �6GOP[OY��W X  a �%j O*�a  ��� [OY��UO_ !a ",E` #O�_ !a ",FO�a $&E�O_ #_ !a ",FOa % /*j O*a &a 'a (b   a )%a *a +j ,a - .E` /UOa 0 1_ /a 1el 2E` 3O �a 4_ /l 5W X 6 hO_ /j 7UOa  i `*a -[a a l kh   ' !�a -[a a l kh �j 8[OY��W X  a 9�%j O*�a :��� O[OY��O*j ;U ascr  ��ޭ