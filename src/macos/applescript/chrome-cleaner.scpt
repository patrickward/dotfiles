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
 l     ��������  ��  ��        j     �� ��  0 reportfilename reportFileName  m        �    c h r o m e - t a b s      l     ��������  ��  ��        i        I      �� ���� 0 quotecsv quoteCSV   ��  o      ���� 0 _string  ��  ��    k            r         m        �    "  o      ���� 0 dq      ��   L     ! ! b     " # " b     $ % $ o    ���� 0 dq   % n    & ' & I    �� (���� 0 replace   (  ) * ) o    ���� 0 _string   *  + , + o    ���� 0 dq   ,  -�� - b     . / . o    	���� 0 dq   / o   	 
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
TEXT��  ��   � l      ����� � o      ���� 0 	datestamp 	dateStamp��  ��  ��  ��   �  � � � l   $ ����� � r    $ � � � b    " � � � I     �� ����� 0 quotecsv quoteCSV �  ��� � b     � � � b     � � � o    ����  0 reportfilename reportFileName � m     � � � � � 
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
dfnm[ b  ]^] o  �%�%  0 reportfilename reportFileName^ l 	_�$�#_ m  `` �aa  . c s v�$  �#  \ �"b�!
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
 cu             CoreServices  0/:System:Library:CoreServices:System Events.app/  $  S y s t e m   E v e n t s . a p p    M a c i n t o s h   H D  -System/Library/CoreServices/System Events.app   / ��  �  �  n ��� l     �� ���  �   ��  � ��� l     ������  �   Finally close all tabs   � ��� .   F i n a l l y   c l o s e   a l l   t a b s� ��� l     ��������  ��  ��  � ��� l      ������  �_Ytell application "Google Chrome"	repeat with theWindow in windows		try			repeat with theTab in (tabs of theWindow)				close theTab			end repeat		on error errorMsg			log "Error (chrome-cleaner): " & errorMsg			display notification with title "ERROR (chrome-cleaner)" subtitle errorMsg			exit repeat		end try	end repeat	quitend tell   � ����  t e l l   a p p l i c a t i o n   " G o o g l e   C h r o m e "  	 r e p e a t   w i t h   t h e W i n d o w   i n   w i n d o w s  	 	 t r y  	 	 	 r e p e a t   w i t h   t h e T a b   i n   ( t a b s   o f   t h e W i n d o w )  	 	 	 	 c l o s e   t h e T a b  	 	 	 e n d   r e p e a t  	 	 o n   e r r o r   e r r o r M s g  	 	 	 l o g   " E r r o r   ( c h r o m e - c l e a n e r ) :   "   &   e r r o r M s g  	 	 	 d i s p l a y   n o t i f i c a t i o n   w i t h   t i t l e   " E R R O R   ( c h r o m e - c l e a n e r ) "   s u b t i t l e   e r r o r M s g  	 	 	 e x i t   r e p e a t  	 	 e n d   t r y  	 e n d   r e p e a t  	 q u i t  e n d   t e l l � ��� l     ��������  ��  ��  � ��� l     ��������  ��  ��  � ��� l     ��������  ��  ��  � ��� l     ��������  ��  ��  � ��� l     ��������  ��  ��  � ���� l     ��������  ��  ��  ��       ��� �����������������������������  � ������������������������������������������  0 reportfilename reportFileName�� 0 quotecsv quoteCSV�� 0 replace  �� 0 join  
�� .aevtoappnull  �   � ****
�� 
lnfd�� 0 	datestamp 	dateStamp�� 0 	notetitle 	noteTitle�� 0 urllist urlList�� 0 tablist tabList�� 0 olddelim oldDelim�� 0 savefile saveFile�� 0 savefiel saveFiel��  ��  ��  ��  ��  ��  ��  � �� ���������� 0 quotecsv quoteCSV�� ����� �  ���� 0 _string  ��  � ������ 0 _string  �� 0 dq  �  ���� 0 replace  �� �E�O�)����%m+ %�%� �� 5���������� 0 replace  �� ����� �  �������� 0 _string  �� 0 _source  �� 0 _replacement  ��  � ���������� 0 _string  �� 0 _source  �� 0 _replacement  �� 
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
�� .aevtoappnull  �   � ****� k    i��  z��  ���  ���  ���  ���  ��� "�� )�� 0�� 8�� K�� m����  ��  ��  � �������� 0 	thewindow 	theWindow�� 0 thetab theTab�� 0 errormsg errorMsg� 8������������ ��� ������� ������������������������� �������������~�}e�|Y�{`�z�y�x�w�v�u��t�s�r�q�p�o�n�� 

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
� 
txdl�~ 0 olddelim oldDelim
�} 
ctxt
�| 
prmt
�{ 
dfnm
�z 
dflc
�y afdmdesk
�x .earsffdralis        afdr�w 
�v .sysonwflfile    ��� null�u 0 savefile saveFile
�t 
perm
�s .rdwropenshor       file�r 0 savefiel saveFiel
�q 
refn
�p .rdwrwritnull���     ****�o  
�n .rdwrclosnull���     ****��j�j E�O*j �&E�O*b   �%�%k+ �%E�O�kvE�O*����� Oa  �*j O �*a -[a a l kh   Y S�a -[a a l kh jvE` O)�a ,k+ _ 6GO)�a ,k+ _ 6GO)_ a l+ �6GOP[OY��W X  a �%j O*�a  ��� [OY��UO_ !a ",E` #O�_ !a ",FO�a $&E�O_ #_ !a ",FOa % /*j O*a &a 'a (b   a )%a *a +j ,a - .E` /UOa 0 1_ /a 1el 2E` 3O �a 4_ /l 5W X 6 hO_ /j 7U� ���  
� ��� P S a t u r d a y ,   F e b r u a r y   2 ,   2 0 1 9   a t   6 : 2 2 : 4 4   P M� ��� � " c h r o m e - t a b s   f o r   S a t u r d a y ,   F e b r u a r y   2 ,   2 0 1 9   a t   6 : 2 2 : 4 4   P M " ,   U R L S� ���s0 " c h r o m e - t a b s   f o r   S a t u r d a y ,   F e b r u a r y   2 ,   2 0 1 9   a t   6 : 2 2 : 4 4   P M " ,   U R L S 
 " D i s c o v e r   C a r d :   S e s s i o n   E n d e d " , " h t t p s : / / p o r t a l . d i s c o v e r . c o m / c u s t o m e r s v c s / u n i v e r s a l L o g i n / t i m e o u t _ c o n f i r m e d " 
 " n o t e s   i c o n   a t   D u c k D u c k G o " , " h t t p s : / / d u c k d u c k g o . c o m / ? q = n o t e s + i c o n & a t b = v 3 3 - 7 _ _ & i a = i m a g e s & i a x = i m a g e s & i a i = h t t p % 3 A % 2 F % 2 F i c o n s . i c o n a r c h i v e . c o m % 2 F i c o n s % 2 F p e l f u s i o n % 2 F l o n g - s h a d o w - i o s 7 % 2 F 1 0 2 4 % 2 F N o t e s - i c o n . p n g " 
 " S c r i p t   F i l t e r   -   W o r k f l o w   I n p u t   O b j e c t s   -   A l f r e d   H e l p   a n d   S u p p o r t " , " h t t p s : / / w w w . a l f r e d a p p . c o m / h e l p / w o r k f l o w s / i n p u t s / s c r i p t - f i l t e r / # b e h a v i o u r " 
 " S c r i p t   F i l t e r   J S O N   F o r m a t   -   W o r k f l o w   I n p u t   O b j e c t s   -   A l f r e d   H e l p   a n d   S u p p o r t " , " h t t p s : / / w w w . a l f r e d a p p . c o m / h e l p / w o r k f l o w s / i n p u t s / s c r i p t - f i l t e r / j s o n / " 
 " s h e l l   s c r i p t   s u b r o u t i n e   a t   D u c k D u c k G o " , " h t t p s : / / d u c k d u c k g o . c o m / ? q = s h e l l + s c r i p t + s u b r o u t i n e & a t b = v 3 3 - 7 _ _ & i a = w e b " 
 " F u n c t i o n s   -   S h e l l   S c r i p t i n g   T u t o r i a l " , " h t t p s : / / w w w . s h e l l s c r i p t . s h / f u n c t i o n s . h t m l " 
 " u n i x   l s   l i s t   f i l e n a m e s   o n l y   v e r t i c a l l y   a t   D u c k D u c k G o " , " h t t p s : / / d u c k d u c k g o . c o m / ? q = u n i x + l s + l i s t + f i l e n a m e s + o n l y + v e r t i c a l l y & a t b = v 3 3 - 7 _ _ & i a = w e b " 
 " u n i x   -   H o w   t o   g e t   a   l i s t   o f   f i l e   n a m e s   i n   d i f f e r e n t   l i n e s   -   S t a c k   O v e r f l o w " , " h t t p s : / / s t a c k o v e r f l o w . c o m / q u e s t i o n s / 5 1 5 5 6 5 7 / h o w - t o - g e t - a - l i s t - o f - f i l e - n a m e s - i n - d i f f e r e n t - l i n e s " 
 " l i n u x   -   H o w   t o   o u t p u t   o n l y   f i l e   n a m e s   ( w i t h   s p a c e s )   i n   l s   - A l ?   -   U n i x   &   L i n u x   S t a c k   E x c h a n g e " , " h t t p s : / / u n i x . s t a c k e x c h a n g e . c o m / q u e s t i o n s / 7 0 6 1 4 / h o w - t o - o u t p u t - o n l y - f i l e - n a m e s - w i t h - s p a c e s - i n - l s - a l " 
 " W r i t i n g   Z s h   C o m p l e t i o n   F u n c t i o n s   |   L i n u x   M a g a z i n e " , " h t t p : / / w w w . l i n u x - m a g . c o m / i d / 1 1 0 6 / " 
 " z s h - c o m p l e t i o n s / s r c   a t   m a s t e r   �   z s h - u s e r s / z s h - c o m p l e t i o n s " , " h t t p s : / / g i t h u b . c o m / z s h - u s e r s / z s h - c o m p l e t i o n s / t r e e / m a s t e r / s r c " 
 " z s h - c o m p l e t i o n s / _ c o f f e e   a t   m a s t e r   �   z s h - u s e r s / z s h - c o m p l e t i o n s " , " h t t p s : / / g i t h u b . c o m / z s h - u s e r s / z s h - c o m p l e t i o n s / b l o b / m a s t e r / s r c / _ c o f f e e " 
 " T h e   c a s e   s t a t e m e n t   -   L i n u x   S h e l l   S c r i p t i n g   T u t o r i a l   -   A   B e g i n n e r ' s   h a n d b o o k " , " h t t p s : / / b a s h . c y b e r c i t i . b i z / g u i d e / T h e _ c a s e _ s t a t e m e n t " 
 " s h e l l   s e e   i f   $ 1   i s   e m p t y   a t   D u c k D u c k G o " , " h t t p s : / / d u c k d u c k g o . c o m / ? q = s h e l l + s e e + i f + % 2 4 1 + i s + e m p t y & a t b = v 3 3 - 7 _ _ & i a = w e b " 
 " T e s t i n g   i f   a   v a r i a b l e   i s   e m p t y   i n   a   s h e l l   s c r i p t   -   U n i x   &   L i n u x   S t a c k   E x c h a n g e " , " h t t p s : / / u n i x . s t a c k e x c h a n g e . c o m / q u e s t i o n s / 3 2 1 8 0 / t e s t i n g - i f - a - v a r i a b l e - i s - e m p t y - i n - a - s h e l l - s c r i p t " 
 " W h a t   d o e s   $ #   m e a n   i n   s h e l l ?   -   U n i x   &   L i n u x   S t a c k   E x c h a n g e " , " h t t p s : / / u n i x . s t a c k e x c h a n g e . c o m / q u e s t i o n s / 1 2 2 3 4 3 / w h a t - d o e s - m e a n - i n - s h e l l " 
 " z s h   c o m p l e t i o n   _ a r g u m e n t s   a t   D u c k D u c k G o " , " h t t p s : / / d u c k d u c k g o . c o m / ? q = z s h + c o m p l e t i o n + _ a r g u m e n t s & a t b = v 3 3 - 7 _ _ & i a = w e b " 
 " z s h - c o m p l e t i o n s / z s h - c o m p l e t i o n s - h o w t o . o r g   a t   m a s t e r   �   z s h - u s e r s / z s h - c o m p l e t i o n s " , " h t t p s : / / g i t h u b . c o m / z s h - u s e r s / z s h - c o m p l e t i o n s / b l o b / m a s t e r / z s h - c o m p l e t i o n s - h o w t o . o r g " 
 " W r i t i n g   z s h   c o m p l e t i o n   s c r i p t s " , " h t t p s : / / m a d s - h a r t m a n n . c o m / 2 0 1 7 / 0 8 / 0 6 / w r i t i n g - z s h - c o m p l e t i o n - s c r i p t s . h t m l " 
 " b a s h   c h e c k   f o r   a n y   f i l e   e x t e n s i o n   i n   a   s t r i n g   a t   D u c k D u c k G o " , " h t t p s : / / d u c k d u c k g o . c o m / ? q = b a s h + c h e c k + f o r + a n y + f i l e + e x t e n s i o n + i n + a + s t r i n g & a t b = v 3 3 - 7 _ _ & i a = w e b " 
 " b a s h   -   G r a b b i n g   t h e   e x t e n s i o n   i n   a   f i l e   n a m e   -   U n i x   &   L i n u x   S t a c k   E x c h a n g e " , " h t t p s : / / u n i x . s t a c k e x c h a n g e . c o m / q u e s t i o n s / 1 5 7 1 / g r a b b i n g - t h e - e x t e n s i o n - i n - a - f i l e - n a m e " 
 " s h e l l   -   E a s i e s t   w a y   t o   c h e c k   f o r   f i l e   e x t e n s i o n   i n   b a s h ?   -   S t a c k   O v e r f l o w " , " h t t p s : / / s t a c k o v e r f l o w . c o m / q u e s t i o n s / 1 8 2 7 8 9 9 0 / e a s i e s t - w a y - t o - c h e c k - f o r - f i l e - e x t e n s i o n - i n - b a s h " 
 " b a s h   -   H o w   t o   s p l i t   a   s t r i n g   i n   s h e l l   a n d   g e t   t h e   l a s t   f i e l d   -   S t a c k   O v e r f l o w " , " h t t p s : / / s t a c k o v e r f l o w . c o m / q u e s t i o n s / 3 1 6 2 3 8 5 / h o w - t o - s p l i t - a - s t r i n g - i n - s h e l l - a n d - g e t - t h e - l a s t - f i e l d ? n o r e d i r e c t = 1 & l q = 1 " 
 " z s h   c o m p l e t i o n   f o r   s p e c i f i c   d i r e c t o r y   a t   D u c k D u c k G o " , " h t t p s : / / d u c k d u c k g o . c o m / ? q = z s h + c o m p l e t i o n + f o r + s p e c i f i c + d i r e c t o r y & a t b = v 3 3 - 7 _ _ & i a = w e b " 
 " o s x   -   z s h   c o m p l e t i o n :   g e t t i n g   f i l e   n a m e s   f r o m   a   s p e c i f i c   d i r e c t o r y   -   U n i x   &   L i n u x   S t a c k   E x c h a n g e " , " h t t p s : / / u n i x . s t a c k e x c h a n g e . c o m / q u e s t i o n s / 6 4 9 8 4 / z s h - c o m p l e t i o n - g e t t i n g - f i l e - n a m e s - f r o m - a - s p e c i f i c - d i r e c t o r y " 
 " z s h :   2 0   C o m p l e t i o n   S y s t e m " , " h t t p : / / z s h . s o u r c e f o r g e . n e t / D o c / R e l e a s e / C o m p l e t i o n - S y s t e m . h t m l # i n d e x - _ 0 0 5 f p a t h _ 0 0 5 f f i l e s " 
 " H o w   t o   P r o t e c t   Y o u r   P r i v a c y   o n   i P h o n e   a n d   i P a d " , " h t t p s : / / s p r e a d p r i v a c y . c o m / i p h o n e - p r i v a c y - t i p s / " 
 " M a c " , " h t t p s : / / o l d . r e d d i t . c o m / r / m a c / " 
 " H a m m e r s p o o n   S p o o n s   D o c s " , " h t t p : / / w w w . h a m m e r s p o o n . o r g / S p o o n s / " 
 " m a c a p p s :   s e a r c h   r e s u l t s   -   v i m " , " h t t p s : / / o l d . r e d d i t . c o m / r / m a c a p p s / s e a r c h ? q = v i m & r e s t r i c t _ s r = o n " 
 " V i m   A w e s o m e " , " h t t p s : / / v i m a w e s o m e . c o m / " 
 " j a m e s s a n / v i m - g n u p g :   T h i s   s c r i p t   i m p l e m e n t s   t r a n s p a r e n t   e d i t i n g   o f   g p g   e n c r y p t e d   f i l e s .   T h e   f i l e n a m e   m u s t   h a v e   a   " " . g p g " " ,   " " . p g p " "   o r   " " . a s c " "   s u f f i x .   W h e n   o p e n i n g   s u c h   a   f i l e   t h e   c o n t e n t   i s   d e c r y p t e d ,   w h e n   o p e n i n g   a   n e w   f i l e   t h e   s c r i p t   w i l l   a s k   f o r   t h e   r e c i p i e n t s   o f   t h e   e n c r y p t e d   f i l e .   T h e   f i l e   c o n t e n t   w i l l   b e   e n c r y p t e d   t o   a l l   r e c i p i e n t s   b e f o r e   i t   i s   w r i t t e n .   T h e   s c r i p t   t u r n s   o f f   v i m i n f o ,   s w a p f i l e ,   a n d   u n d o f i l e   t o   i n c r e a s e   s e c u r i t y . " , " h t t p s : / / g i t h u b . c o m / j a m e s s a n / v i m - g n u p g " 
 " E n c r y p t   f i l e s   w i t h   v i m      T u x d i a r y " , " h t t p : / / t u x d i a r y . c o m / 2 0 1 5 / 0 1 / 1 3 / e n c r y p t - f i l e s - w i t h - v i m / " 
 " e n c r y p t   v i m w i k i   a t   D u c k D u c k G o " , " h t t p s : / / d u c k d u c k g o . c o m / ? q = e n c r y p t + v i m w i k i & a t b = v 3 3 - 7 _ _ & i a = w e b " 
 " e n c r y p t i o n   -   v i m :   i s   p o s s i b l e   t o   o p e n   a   e n c r y p t e d   f i l e   u s i n g   c l i ?   -   U n i x   &   L i n u x   S t a c k   E x c h a n g e " , " h t t p s : / / u n i x . s t a c k e x c h a n g e . c o m / q u e s t i o n s / 3 5 0 6 1 0 / v i m - i s - p o s s i b l e - t o - o p e n - a - e n c r y p t e d - f i l e - u s i n g - c l i " 
 " H o w   I   T a k e   N o t e s   :   v i m " , " h t t p s : / / w w w . r e d d i t . c o m / r / v i m / c o m m e n t s / 8 r u g j q / h o w _ i _ t a k e _ n o t e s / " 
 " s e a r c h - e d i t / s e a r c h . s h   a t   m a s t e r   �   S t e f a n M a j o n e z / s e a r c h - e d i t   �   G i t H u b " , " h t t p s : / / g i t h u b . c o m / S t e f a n M a j o n e z / s e a r c h - e d i t / b l o b / m a s t e r / s e a r c h . s h " 
 " G i t H u b   -   l e r v a g / w i k i . v i m :   A   w i k i   p l u g i n   f o r   V i m " , " h t t p s : / / g i t h u b . c o m / l e r v a g / w i k i . v i m " 
 " H o w   I   T a k e   N o t e s   |   a o n e m d " , " h t t p s : / / a o n e m d . g i t h u b . i o / b l o g / h o w - i - t a k e - n o t e s " 
 " S o f t w a r e   E n g i n e e r s   s h o u l d   k e e p   l a b   n o t e b o o k s   -   M a d e   o f   B u g s " , " h t t p s : / / b l o g . n e l h a g e . c o m / 2 0 1 0 / 0 5 / s o f t w a r e - a n d - l a b - n o t e b o o k s / " 
 " I n t r o d u c t i o n   t o   V i m w i k i   :   v i m " , " h t t p s : / / w w w . r e d d i t . c o m / r / v i m / c o m m e n t s / 6 c 5 9 9 8 / i n t r o d u c t i o n _ t o _ v i m w i k i / " 
 " U s i n g   V i m W i k i   a s   a   d i s t r i b u t e d ,   e n c r y p t e d   l a b   n o t e b o o k   f o r   p r o g r a m m i n g      S t o c h a s t i c   G e o m e t r y " , " h t t p : / / w w w . s t o c h a s t i c g e o m e t r y . i e / 2 0 1 2 / 1 1 / 2 3 / v i m w i k i / " 
 " P e r s o n a l   w i k i   u s i n g   V i m w i k i      B e n j a m i n   C a c c i a " , " h t t p s : / / b c a c c i a a u d i o . c o m / 2 0 1 8 / 1 0 / 1 0 / p e r s o n a l - w i k i - u s i n g - v i m w i k i / " 
 " i o s   e n c r y p t   d e c r y p t   f i l e s   w i t h   b c r y p t   a t   D u c k D u c k G o " , " h t t p s : / / d u c k d u c k g o . c o m / ? q = i o s + e n c r y p t + d e c r y p t + f i l e s + w i t h + b c r y p t & a t b = v 3 3 - 7 _ _ & i a = w e b " 
 " s w i f t   -   H o w   t o   e n c r y p t / d e c r y p t   a   f i l e   i n   i O S ?   -   S t a c k   O v e r f l o w " , " h t t p s : / / s t a c k o v e r f l o w . c o m / q u e s t i o n s / 4 3 4 3 5 7 8 5 / h o w - t o - e n c r y p t - d e c r y p t - a - f i l e - i n - i o s " 
 " S Q L C i p h e r   C o m m u n i t y   E d i t i o n   -   i O S   a n d   m a c O S   T u t o r i a l   -   Z e t e t i c " , " h t t p s : / / w w w . z e t e t i c . n e t / s q l c i p h e r / i o s - t u t o r i a l / " 
 " P y t h o n i s t a / H o w   t o   A E S   e n c r y p t d e c r y p t   f i l e s   u s i n g   P y t h o n P y C r y p t o   i n   a n   O p e n S S L - c o m p a t i b l e   w a y ? . m d   a t   m a s t e r   �   t d a m d o u n i / P y t h o n i s t a " , " h t t p s : / / g i t h u b . c o m / t d a m d o u n i / P y t h o n i s t a / b l o b / m a s t e r / _ W e b A r t i c l e s / H o w % 2 0 t o % 2 0 A E S % 2 0 e n c r y p t d e c r y p t % 2 0 f i l e s % 2 0 u s i n g % 2 0 P y t h o n P y C r y p t o % 2 0 i n % 2 0 a n % 2 0 O p e n S S L - c o m p a t i b l e % 2 0 w a y % 3 F . m d " 
 " P y t h o n i s t a / c l o u d - f i l e - w i t h - a e s - e n c r y p t i o n . p y   a t   m a s t e r   �   t d a m d o u n i / P y t h o n i s t a " , " h t t p s : / / g i t h u b . c o m / t d a m d o u n i / P y t h o n i s t a / b l o b / m a s t e r / c l o u d / c l o u d - f i l e - w i t h - a e s - e n c r y p t i o n . p y " 
 " P y t h o n i s t a / t e x t v i e w   a t   m a s t e r   �   t d a m d o u n i / P y t h o n i s t a " , " h t t p s : / / g i t h u b . c o m / t d a m d o u n i / P y t h o n i s t a / t r e e / m a s t e r / t e x t v i e w " 
 " P y t h o n i s t a / e d i t m e n u _ s i m p l e . p y   a t   9 6 a c 4 0 d f 1 5 0 b 5 9 b c 4 2 a b 6 f e e 3 b 7 e f 1 c 3 d d 0 d 1 1 0 e   �   t d a m d o u n i / P y t h o n i s t a " , " h t t p s : / / g i t h u b . c o m / t d a m d o u n i / P y t h o n i s t a / b l o b / 9 6 a c 4 0 d f 1 5 0 b 5 9 b c 4 2 a b 6 f e e 3 b 7 e f 1 c 3 d d 0 d 1 1 0 e / e d i t o r / e d i t m e n u _ s i m p l e . p y " 
 " S e a r c h   �   p y t h o n i s t a " , " h t t p s : / / g i t h u b . c o m / s e a r c h ? l = P y t h o n & q = p y t h o n i s t a & t y p e = R e p o s i t o r i e s " 
 " P y t h o n i s t a S c r i p t s / D r o p b o x S y n c . p y   a t   m a s t e r   �   d h u t c h i s o n / P y t h o n i s t a S c r i p t s " , " h t t p s : / / g i t h u b . c o m / d h u t c h i s o n / P y t h o n i s t a S c r i p t s / b l o b / m a s t e r / D r o p b o x S y n c . p y " 
 " h u m b e r r y / u i - t u t o r i a l :   P y t h o n i s t a " , " h t t p s : / / g i t h u b . c o m / h u m b e r r y / u i - t u t o r i a l " 
 " d g e l e s s u s / p y t h o n i s t a - s c r i p t s :   A   c o l l e c t i o n   o f   v a r i o u s   P y t h o n i s t a   s c r i p t s . " , " h t t p s : / / g i t h u b . c o m / d g e l e s s u s / p y t h o n i s t a - s c r i p t s " 
 " p y t h o n i s t a   e n c r y p t   f i l e s   -   G o o g l e   S e a r c h " , " h t t p s : / / w w w . g o o g l e . c o m / s e a r c h ? h l = e n & q = p y t h o n i s t a % 2 0 e n c r y p t % 2 0 f i l e s " 
 " B e s t   c u r r e n t   m e t h o d s   f o r   r o u n d   t r i p   f i l e s   t o   p y t h o n i s t a   f r o m   a   m a c b o o k   |   o m z : f o r u m " , " h t t p s : / / f o r u m . o m z - s o f t w a r e . c o m / t o p i c / 5 0 4 2 / b e s t - c u r r e n t - m e t h o d s - f o r - r o u n d - t r i p - f i l e s - t o - p y t h o n i s t a - f r o m - a - m a c b o o k / 7 " 
 " P y t h o n i s t a   T o o l s " , " h t t p s : / / p y t h o n i s t a - t o o l s . g i t h u b . i o / P y t h o n i s t a - T o o l s / " 
 " i E d i t o r / i e d i t o r . p y   a t   m a s t e r   �   G o D z M 4 T T 3 O / i E d i t o r " , " h t t p s : / / g i t h u b . c o m / G o D z M 4 T T 3 O / i E d i t o r / b l o b / m a s t e r / i e d i t o r . p y " 
 " s i t e : o m z - s o f t w a r e . c o m   s a v e   i c l o u d   f i l e   -   G o o g l e   S e a r c h " , " h t t p s : / / w w w . g o o g l e . c o m / s e a r c h ? h l = e n & e i = 2 b B V X N r t F M u e 5 g K h _ 4 2 o B g & q = s i t e % 3 A o m z - s o f t w a r e . c o m + s a v e + i c l o u d + f i l e & o q = s i t e % 3 A o m z - s o f t w a r e . c o m + s a v e + i c l o u d + f i l e & g s _ l = p s y - a b . 3 . . . 1 1 3 6 0 . 1 2 0 1 4 . . 1 2 3 4 2 . . . 0 . 0 . . 0 . 8 7 . 3 8 6 . 5 . . . . . . 0 . . . . 1 . . g w s - w i z . Z 0 T C F u 4 Z r W w " 
 " o m z : f o r u m " , " h t t p s : / / f o r u m . o m z - s o f t w a r e . c o m / s e a r c h / i c l o u d % 2 0 e d i t o r ? i n = t i t l e s p o s t s & s o r t B y = t i m e s t a m p & s o r t D i r e c t i o n = d e s c & s h o w A s = p o s t s " 
 " e d d o 8 8 8   |   o m z : f o r u m " , " h t t p s : / / f o r u m . o m z - s o f t w a r e . c o m / u s e r / e d d o 8 8 8 " 
 " O v e r v i e w      E d i t o r i a l   D o c u m e n t a t i o n " , " h t t p : / / o m z - s o f t w a r e . c o m / e d i t o r i a l / d o c s / " 
 " E d i t o r i a l   W o r k f l o w s   -   S e a r c h :   e n c r y p t " , " h t t p : / / w w w . e d i t o r i a l - w o r k f l o w s . c o m / w o r k f l o w s / s e a r c h ? q = e n c r y p t " 
 " E d i t o r i a l   |   o m z : f o r u m " , " h t t p s : / / f o r u m . o m z - s o f t w a r e . c o m / c a t e g o r y / 6 / e d i t o r i a l " 
 " S a v e   t o   a r b i t r a r y   i C l o u d   D r i v e   p a t h   i n   n e w   P y t h o n i s t a ?   |   o m z : f o r u m " , " h t t p s : / / f o r u m . o m z - s o f t w a r e . c o m / t o p i c / 4 6 0 3 / s a v e - t o - a r b i t r a r y - i c l o u d - d r i v e - p a t h - i n - n e w - p y t h o n i s t a " 
 " E x t e r n a l   f i l e   a c c e s s   |   o m z : f o r u m " , " h t t p s : / / f o r u m . o m z - s o f t w a r e . c o m / t o p i c / 4 6 7 5 / e x t e r n a l - f i l e - a c c e s s / 6 " 
 " E x t e r n a l   f i l e s :   h o w   d o e s   t h a t   w o r k ?   |   o m z : f o r u m " , " h t t p s : / / f o r u m . o m z - s o f t w a r e . c o m / t o p i c / 4 6 0 4 / e x t e r n a l - f i l e s - h o w - d o e s - t h a t - w o r k " 
 " H o w   t o   g e t   a   " " t e x t " "   f i l e   f r o m   i C l o u d   D r i v e   |   o m z : f o r u m " , " h t t p s : / / f o r u m . o m z - s o f t w a r e . c o m / t o p i c / 3 2 6 7 / h o w - t o - g e t - a - t e x t - f i l e - f r o m - i c l o u d - d r i v e " 
 " B a s i c   t e x t   e d i t o r   |   o m z : f o r u m " , " h t t p s : / / f o r u m . o m z - s o f t w a r e . c o m / t o p i c / 1 0 6 0 / b a s i c - t e x t - e d i t o r " 
 " u i - t e x t e d i t o r / t e x t e d i t o r . p y   a t   m a s t e r   �   J a d e d T u n a / u i - t e x t e d i t o r " , " h t t p s : / / g i t h u b . c o m / J a d e d T u n a / u i - t e x t e d i t o r / b l o b / m a s t e r / t e x t e d i t o r . p y " 
 " S c r e e n   r e s o l u t i o n   w i t h   r e t i n a   d i s p l a y   |   o m z : f o r u m " , " h t t p s : / / f o r u m . o m z - s o f t w a r e . c o m / t o p i c / 4 3 8 / s c r e e n - r e s o l u t i o n - w i t h - r e t i n a - d i s p l a y " 
 " l i n u x   -   c h e c k   i f   e n v i r o n m e n t   v a r i a b l e   i s   a l r e a d y   s e t   -   S t a c k   O v e r f l o w " , " h t t p s : / / s t a c k o v e r f l o w . c o m / q u e s t i o n s / 1 1 6 8 6 2 0 8 / c h e c k - i f - e n v i r o n m e n t - v a r i a b l e - i s - a l r e a d y - s e t " 
 " l i n u x   -   z s h :   r a i s e   e r r o r   w h e n   v a r i a b l e   n o t   d e f i n e d   -   S t a c k   O v e r f l o w " , " h t t p s : / / s t a c k o v e r f l o w . c o m / q u e s t i o n s / 3 4 6 1 1 1 1 8 / z s h - r a i s e - e r r o r - w h e n - v a r i a b l e - n o t - d e f i n e d " 
 " V i m   A w e s o m e " , " h t t p s : / / v i m a w e s o m e . c o m / ? q = n o t e s " 
 " n o t e s . v i m   -   V i m   A w e s o m e " , " h t t p s : / / v i m a w e s o m e . c o m / p l u g i n / n o t e s - v i m " 
 " I s s u e s   �   x o l o x / v i m - n o t e s " , " h t t p s : / / g i t h u b . c o m / x o l o x / v i m - n o t e s / i s s u e s " 
 " e d i t   b e a r   n o t e s   i n   e x t e r n a l   e d i t o r   a t   D u c k D u c k G o " , " h t t p s : / / d u c k d u c k g o . c o m / ? q = e d i t + b e a r + n o t e s + i n + e x t e r n a l + e d i t o r & a t b = v 3 3 - 7 _ _ & i a = w e b " 
 " X   c a l l b a c k   u r l   S c h e m e   d o c u m e n t a t i o n   -   B e a r   -   F a q   a n d   s u p p o r t " , " h t t p s : / / b e a r . a p p / f a q / X - c a l l b a c k - u r l % 2 0 S c h e m e % 2 0 d o c u m e n t a t i o n / " 
 " X   c a l l b a c k   u r l   S c h e m e   d o c u m e n t a t i o n   -   B e a r   -   F a q   a n d   s u p p o r t " , " h t t p s : / / b e a r . a p p / f a q / X - c a l l b a c k - u r l % 2 0 S c h e m e % 2 0 d o c u m e n t a t i o n / # c r e a t e " 
 " a l f r e d   a p p   b e a r   a t   D u c k D u c k G o " , " h t t p s : / / d u c k d u c k g o . c o m / ? q = a l f r e d + a p p + b e a r & a t b = v 3 3 - 7 _ _ & i a = w e b " 
 " B e a r   w o r k f l o w   -   s e a r c h   a n d   c r e a t e   n o t e s   -   S h a r e   y o u r   W o r k f l o w s   -   A l f r e d   A p p   C o m m u n i t y   F o r u m " , " h t t p s : / / w w w . a l f r e d f o r u m . c o m / t o p i c / 1 0 4 0 3 - b e a r - w o r k f l o w - s e a r c h - a n d - c r e a t e - n o t e s / " 
 " S e a r c h   B e a r   n o t e s   f r o m   A l f r e d      l d s t e p h e n s " , " h t t p s : / / l d s t e p h e n s . n e t / 2 0 1 8 / 0 3 / 0 4 / s e a r c h - b e a r - n o t e s - f r o m - a l f r e d / " 
 " B e a r   |   P a c k a l " , " h t t p : / / w w w . p a c k a l . o r g / w o r k f l o w / b e a r " 
 " k o n r a d 1 2 6 / a l f r e d - b e a r :   A l f r e d   B e a r   A p p   W o r k f l o w " , " h t t p s : / / g i t h u b . c o m / k o n r a d 1 2 6 / a l f r e d - b e a r " 
 " R e m e m b e r   t h e   M i l k   -   S h a r e   y o u r   W o r k f l o w s   -   A l f r e d   A p p   C o m m u n i t y   F o r u m " , " h t t p s : / / w w w . a l f r e d f o r u m . c o m / t o p i c / 3 6 4 8 - r e m e m b e r - t h e - m i l k / " 
 " t p o p e / r u m e m b e r :   R e m e m b e r   T h e   M i l k   R u b y   A P I   a n d   c o m m a n d   l i n e   i n t e r f a c e " , " h t t p s : / / g i t h u b . c o m / t p o p e / r u m e m b e r " 
 " r e m e m b e r   t h e   m i l k   c o m m a n d   l i n e   a t   D u c k D u c k G o " , " h t t p s : / / d u c k d u c k g o . c o m / ? q = r e m e m b e r + t h e + m i l k + c o m m a n d + l i n e & a t b = v 3 3 - 7 _ _ & i a = s o f t w a r e " 
 " d w a r i n g 8 7 / r t m - c l i :   R e m e m b e r   t h e   M i l k   C o m m a n d   L i n e   I n t e r f a c e " , " h t t p s : / / g i t h u b . c o m / d w a r i n g 8 7 / r t m - c l i " 
 " A l l   T a s k s   ( 1 7 8 )   -   R e m e m b e r   T h e   M i l k " , " h t t p s : / / w w w . r e m e m b e r t h e m i l k . c o m / a p p / # a l l " 
 " A l l   T a s k s   ( 1 7 8 )   -   R e m e m b e r   T h e   M i l k " , " h t t p s : / / w w w . r e m e m b e r t h e m i l k . c o m / a p p / # a l l " 
 " R e m e m b e r   T h e   M i l k   -   S e r v i c e s   /   A P I   /   B r a n d i n g   G u i d e l i n e s " , " h t t p s : / / w w w . r e m e m b e r t h e m i l k . c o m / s e r v i c e s / a p i / b r a n d i n g . r t m " 
 " r e m e m b e r   t h e   m i l k   i c o n   a t   D u c k D u c k G o " , " h t t p s : / / d u c k d u c k g o . c o m / ? q = r e m e m b e r + t h e + m i l k + i c o n & a t b = v 3 3 - 7 _ _ & i a = i m a g e s & i a x = i m a g e s & i a i = h t t p % 3 A % 2 F % 2 F i s 5 . m z s t a t i c . c o m % 2 F i m a g e % 2 F t h u m b % 2 F P u r p l e 1 1 1 % 2 F v 4 % 2 F 3 d % 2 F 2 b % 2 F a e % 2 F 3 d 2 b a e 0 7 - 3 c e 8 - b 4 6 1 - e 9 f c - f c 6 6 7 4 d 2 6 d 3 d % 2 F s o u r c e % 2 F 1 2 0 0 x 6 3 0 b b . j p g " 
 " 1 2 0 0 x 6 3 0 b b . j p g   ( 6 3 0 � 6 3 0 ) " , " h t t p : / / i s 5 . m z s t a t i c . c o m / i m a g e / t h u m b / P u r p l e 1 1 1 / v 4 / 3 d / 2 b / a e / 3 d 2 b a e 0 7 - 3 c e 8 - b 4 6 1 - e 9 f c - f c 6 6 7 4 d 2 6 d 3 d / s o u r c e / 1 2 0 0 x 6 3 0 b b . j p g " 
 " L i s t   F i l t e r   I n p u t   -   A l f r e d   H e l p   a n d   S u p p o r t " , " h t t p s : / / w w w . a l f r e d a p p . c o m / h e l p / w o r k f l o w s / i n p u t s / l i s t - f i l t e r / " 
 " W o r k f l o w s   -   A l f r e d   H e l p   a n d   S u p p o r t " , " h t t p s : / / w w w . a l f r e d a p p . c o m / h e l p / w o r k f l o w s / " 
 " A l f r e d   S e a r c h   -   S e a r c h   R e s u l t s " , " h t t p s : / / w w w . a l f r e d a p p . c o m / s e a r c h / ? p = h e l p & q = r e t u r n i n g + v a l u e s + f r o m + a + s c r i p t " 
 " o m z : f o r u m " , " h t t p s : / / f o r u m . o m z - s o f t w a r e . c o m / s e a r c h / a b a n d o n e d ? i n = t i t l e s p o s t s " 
 " o m z   |   o m z : f o r u m " , " h t t p s : / / f o r u m . o m z - s o f t w a r e . c o m / u s e r / o m z " 
 " r e d d i t :   t h e   f r o n t   p a g e   o f   t h e   i n t e r n e t " , " h t t p s : / / o l d . r e d d i t . c o m / " 
 " s h o r t c u t s :   s e a r c h   r e s u l t s   -   p y t h o n i s t a " , " h t t p s : / / o l d . r e d d i t . c o m / r / s h o r t c u t s / s e a r c h ? q = p y t h o n i s t a & r e s t r i c t _ s r = o n " 
 " P y t h o n i s t a   :   s h o r t c u t s " , " h t t p s : / / o l d . r e d d i t . c o m / r / s h o r t c u t s / c o m m e n t s / a 9 a 2 9 t / p y t h o n i s t a / " 
 " h o w   t o   g e t   d a t a   p a s s e d   f r o m   P y t h o n i s t a   :   s h o r t c u t s " , " h t t p s : / / o l d . r e d d i t . c o m / r / s h o r t c u t s / c o m m e n t s / a d m 6 3 n / h o w _ t o _ g e t _ d a t a _ p a s s e d _ f r o m _ p y t h o n i s t a / " 
 " a l e x a n d e r - a k h m e t o v / p y t h o n - s h o r t c u t s :   C r e a t e   S i r i   S h o r t c u t s   w i t h   P y t h o n " , " h t t p s : / / g i t h u b . c o m / a l e x a n d e r - a k h m e t o v / p y t h o n - s h o r t c u t s " 
 " I s   o l d   P y t h o n i s t a   d e p r e c a t e d ?   :   s h o r t c u t s " , " h t t p s : / / o l d . r e d d i t . c o m / r / s h o r t c u t s / c o m m e n t s / 9 s d q 3 n / i s _ o l d _ p y t h o n i s t a _ d e p r e c a t e d / " 
 " h o w   t o   u s e   p y t h o n i s t a   w i t h   i o s   s h o r t c u t s   a t   D u c k D u c k G o " , " h t t p s : / / d u c k d u c k g o . c o m / ? q = h o w + t o + u s e + p y t h o n i s t a + w i t h + i o s + s h o r t c u t s & a t b = v 3 3 - 7 _ _ & i a = w e b " 
 " S h o r t c u t   a n d   P y t h o n i s t a   :   s h o r t c u t s " , " h t t p s : / / w w w . r e d d i t . c o m / r / s h o r t c u t s / c o m m e n t s / 9 m f 0 b 6 / s h o r t c u t _ a n d _ p y t h o n i s t a / " 
 " P a r s e   E x c e l   F i l e   :   s h o r t c u t s " , " h t t p s : / / w w w . r e d d i t . c o m / r / s h o r t c u t s / c o m m e n t s / a 5 0 t 4 g / p a r s e _ e x c e l _ f i l e / " 
 " F e a t u r e s   S h o r t c u t s   S h o u l d   S t e a l   F r o m   E d i t o r i a l   :   s h o r t c u t s " , " h t t p s : / / o l d . r e d d i t . c o m / r / s h o r t c u t s / c o m m e n t s / a h 3 3 c 0 / f e a t u r e s _ s h o r t c u t s _ s h o u l d _ s t e a l _ f r o m _ e d i t o r i a l / " 
 " i E d i t o r / i e d i t o r . p y   a t   m a s t e r   �   G o D z M 4 T T 3 O / i E d i t o r " , " h t t p s : / / g i t h u b . c o m / G o D z M 4 T T 3 O / i E d i t o r / b l o b / m a s t e r / i e d i t o r . p y " 
 " o m z : f o r u m " , " h t t p s : / / f o r u m . o m z - s o f t w a r e . c o m / s e a r c h / s h o r t c u t s ? i n = t i t l e s p o s t s & _ = 1 5 4 9 1 2 2 6 7 9 6 6 9 & p a g e = 4 " 
 " F r o m   S h o r t c u t s   t o   P y t h o n i s t a   t o   S h o r t c u t s   |   o m z : f o r u m " , " h t t p s : / / f o r u m . o m z - s o f t w a r e . c o m / t o p i c / 5 3 8 3 / f r o m - s h o r t c u t s - t o - p y t h o n i s t a - t o - s h o r t c u t s / 4 " 
 " P y t h o n i s t a   i n t e g r a t i o n   w i t h   S h o r t c u t s   |   o m z : f o r u m " , " h t t p s : / / f o r u m . o m z - s o f t w a r e . c o m / t o p i c / 5 2 3 4 / p y t h o n i s t a - i n t e g r a t i o n - w i t h - s h o r t c u t s / 1 1 " 
 " U s e   x - c a l l b a c k - u r l   w i t h   S h o r t c u t s   -   A p p l e   S u p p o r t " , " h t t p s : / / s u p p o r t . a p p l e . c o m / g u i d e / s h o r t c u t s / u s e - x - c a l l b a c k - u r l - a p d c d 7 f 2 0 a 6 f / i o s " 
 " R u n n i n g   s c r i p t s   s a v e d   i n   i C l o u d   w i t h   S h o r t c u t s   |   o m z : f o r u m " , " h t t p s : / / f o r u m . o m z - s o f t w a r e . c o m / t o p i c / 5 1 3 2 / r u n n i n g - s c r i p t s - s a v e d - i n - i c l o u d - w i t h - s h o r t c u t s "� �m��m �  ���l�k�j�i�h�g�f�e�d�c�b�a�`�_� ��� x " R u n n i n g   s c r i p t s   s a v e d   i n   i C l o u d   w i t h   S h o r t c u t s   |   o m z : f o r u m "� ��� � " h t t p s : / / f o r u m . o m z - s o f t w a r e . c o m / t o p i c / 5 1 3 2 / r u n n i n g - s c r i p t s - s a v e d - i n - i c l o u d - w i t h - s h o r t c u t s "�l  �k  �j  �i  �h  �g  �f  �e  �d  �c  �b  �a  �`  �_  � ���  " "� 5furlfile:///Users/patrickward/Desktop/chrome-tabs.csv�� $��  ��  ��  ��  ��  ��  ��   ascr  ��ޭ