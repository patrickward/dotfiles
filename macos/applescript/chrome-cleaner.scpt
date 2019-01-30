FasdUAS 1.101.10   ��   ��    k             l      ��  ��   *$ 

Exports all Google Chrome tabs to a CSV file. 

This is used in my system alongside a Hazel rule that automatically
moves and renames the CSV file when placed on the Desktop.
	
// Originally inspired by 
Francesco Di Lorenzo (@frankdilo)

// Changed to suit my needs on 
January 30, 2019

     � 	 	H   
 
 E x p o r t s   a l l   G o o g l e   C h r o m e   t a b s   t o   a   C S V   f i l e .   
 
 T h i s   i s   u s e d   i n   m y   s y s t e m   a l o n g s i d e   a   H a z e l   r u l e   t h a t   a u t o m a t i c a l l y 
 m o v e s   a n d   r e n a m e s   t h e   C S V   f i l e   w h e n   p l a c e d   o n   t h e   D e s k t o p . 
 	 
 / /   O r i g i n a l l y   i n s p i r e d   b y   
 F r a n c e s c o   D i   L o r e n z o   ( @ f r a n k d i l o ) 
 
 / /   C h a n g e d   t o   s u i t   m y   n e e d s   o n   
 J a n u a r y   3 0 ,   2 0 1 9 
 
   
  
 l     ��������  ��  ��        j     �� �� 0 reporttitle reportTitle  m        �    C h r o m e   T a b s      l     ��������  ��  ��        l     ����  r         J     ����    o      ���� 0 urllist urlList��  ��        l    ����  r        l    ����  c        l   
  ����   l   
 !���� ! I   
������
�� .misccurdldt    ��� null��  ��  ��  ��  ��  ��    m   
 ��
�� 
TEXT��  ��    l      "���� " o      ���� 0 	datestamp 	dateStamp��  ��  ��  ��     # $ # l    %���� % r     & ' & b     ( ) ( b     * + * b     , - , o    ���� 0 reporttitle reportTitle - m     . . � / / 
   f o r   + l    0���� 0 o    ���� 0 	datestamp 	dateStamp��  ��   ) m     1 1 � 2 2  ,   U R L S ' o      ���� 0 	notetitle 	noteTitle��  ��   $  3 4 3 l     ��������  ��  ��   4  5 6 5 l   � 7���� 7 O    � 8 9 8 k   ! � : :  ; < ; I  ! &������
�� .miscactvnull��� ��� null��  ��   <  =�� = X   ' � >�� ? > k   9 � @ @  A B A l  9 9��������  ��  ��   B  C D C Q   9 � E F G E k   < � H H  I J I l  < <��������  ��  ��   J  K L K X   < � M�� N M k   N � O O  P Q P l  N N��������  ��  ��   Q  R S R r   N S T U T l  N Q V���� V n   N Q W X W 1   O Q��
�� 
pnam X o   N O���� 0 thetab theTab��  ��   U o      ���� 0 tabtitle tabTitle S  Y Z Y r   T ] [ \ [ l  T Y ]���� ] n   T Y ^ _ ^ 1   U Y��
�� 
URL  _ o   T U���� 0 thetab theTab��  ��   \ o      ���� 0 taburl tabUrl Z  ` a ` r   ^ w b c b l  ^ s d���� d b   ^ s e f e b   ^ o g h g b   ^ k i j i b   ^ g k l k b   ^ c m n m m   ^ a o o � p p  " n o   a b���� 0 tabtitle tabTitle l m   c f q q � r r  " ,   j o   g j���� 0 taburl tabUrl h o   k n��
�� 
ret  f o   o r��
�� 
ret ��  ��   c o      ���� 0 tabinfo tabInfo a  s t s s   x ~ u v u o   x {���� 0 tabinfo tabInfo v l      w���� w n       x y x  ;   | } y o   { |���� 0 urllist urlList��  ��   t  z�� z l   ��������  ��  ��  ��  �� 0 thetab theTab N l  ? B {���� { n   ? B | } | 2  @ B��
�� 
CrTb } o   ? @���� 0 	thewindow 	theWindow��  ��   L  ~�� ~ l  � ���������  ��  ��  ��   F R      �� ��
�� .ascrerr ****      � ****  o      ���� 0 errormsg errorMsg��   G I  � ��� ���
�� .ascrcmnt****      � **** � b   � � � � � m   � � � � � � � 0 E r r o r   ( c h r o m e - c l e a n e r ) :   � o   � ����� 0 erromsg erroMsg��   D  ��� � l  � ���������  ��  ��  ��  �� 0 	thewindow 	theWindow ? 2  * -��
�� 
cwin��   9 m     � ��                                                                                  rimZ  alis    >  Macintosh HD                   BD ����Google Chrome.app                                              ����            ����  
 cu             Applications  !/:Applications:Google Chrome.app/   $  G o o g l e   C h r o m e . a p p    M a c i n t o s h   H D  Applications/Google Chrome.app  / ��  ��  ��   6  � � � l     ��������  ��  ��   �  � � � l     �� � ���   �   Convert list to text     � � � � ,   C o n v e r t   l i s t   t o   t e x t   �  � � � l  � � ����� � r   � � � � � n  � � � � � 1   � ���
�� 
txdl � 1   � ���
�� 
ascr � o      ���� 0 olddelim oldDelim��  ��   �  � � � l  � � ����� � r   � � � � � m   � � � � � � �  
 � n      � � � 1   � ���
�� 
txdl � 1   � ���
�� 
ascr��  ��   �  � � � l  � � ����� � r   � � � � � c   � � � � � l  � � ����� � b   � � � � � b   � � � � � b   � � � � � b   � � � � � b   � � � � � m   � � � � � � �  " � o   � ����� 0 	notetitle 	noteTitle � m   � � � � � � �  " ,   U R L 
 � o   � ���
�� 
ret  � o   � ���
�� 
ret  � o   � ����� 0 urllist urlList��  ��   � m   � ���
�� 
ctxt � o      ���� 0 urllist urlList��  ��   �  � � � l  � � ����� � r   � � � � � o   � ����� 0 olddelim oldDelim � n      � � � 1   � ���
�� 
txdl � 1   � ���
�� 
ascr��  ��   �  � � � l     ����~��  �  �~   �  � � � l     �} � ��}   � #  CHOOSE FILE NAME FOR EXPORT     � � � � :   C H O O S E   F I L E   N A M E   F O R   E X P O R T   �  � � � l     �| � ��|   � N H (WRAPPING IN A FINDER FUNCTION SO THE DIALOG WORKS IN ALFRED, KM, ETC.)    � � � � �   ( W R A P P I N G   I N   A   F I N D E R   F U N C T I O N   S O   T H E   D I A L O G   W O R K S   I N   A L F R E D ,   K M ,   E T C . ) �  � � � l  � ��{�z � O   � � � � k   � � �  � � � I  � ��y�x�w
�y .miscactvnull��� ��� null�x  �w   �  ��v � r   � � � � I  ��u�t �
�u .sysonwflfile    ��� null�t   � �s � �
�s 
prmt � m   � � � � � � �  N a m e   t h i s   f i l e : � �r � �
�r 
dfnm � b   �  � � � o   � ��q�q 0 reporttitle reportTitle � l 	 � � ��p�o � m   � � � � � � �  . c s v�p  �o   � �n ��m
�n 
dflc � l 
 ��l�k � I 
�j ��i
�j .earsffdralis        afdr � m  �h
�h afdmdesk�i  �l  �k  �m   � o      �g�g 0 savefile saveFile�v   � m   � � � ��                                                                                  MACS  alis    @  Macintosh HD                   BD ����
Finder.app                                                     ����            ����  
 cu             CoreServices  )/:System:Library:CoreServices:Finder.app/    
 F i n d e r . a p p    M a c i n t o s h   H D  &System/Library/CoreServices/Finder.app  / ��  �{  �z   �  � � � l     �f�e�d�f  �e  �d   �  � � � l     �c � ��c   �  WRITE THE FILE    � � � �  W R I T E   T H E   F I L E �  � � � l L ��b�a � O  L � � � k  K � �  � � � r  + � � � I '�` � �
�` .rdwropenshor       file � o  �_�_ 0 savefile saveFile � �^ ��]
�^ 
perm � m  "#�\
�\ boovtrue�]   � o      �[�[ 0 savefiel saveFiel �  � � � Q  ,C � ��Z � I /:�Y � �
�Y .rdwrwritnull���     **** � o  /0�X�X 0 urllist urlList � �W ��V
�W 
refn � o  36�U�U 0 savefile saveFile�V   � R      �T�S�R
�T .ascrerr ****      � ****�S  �R  �Z   �  ��Q � I DK�P ��O
�P .rdwrclosnull���     **** � o  DG�N�N 0 savefile saveFile�O  �Q   � m   � ��                                                                                  sevs  alis    \  Macintosh HD                   BD ����System Events.app                                              ����            ����  
 cu             CoreServices  0/:System:Library:CoreServices:System Events.app/  $  S y s t e m   E v e n t s . a p p    M a c i n t o s h   H D  -System/Library/CoreServices/System Events.app   / ��  �b  �a   �  �M  l     �L�K�J�L  �K  �J  �M       �I �I   �H�G�H 0 reporttitle reportTitle
�G .aevtoappnull  �   � **** �F�E�D�C
�F .aevtoappnull  �   � **** k    L      #		  5

  �  �  �  �  �  ��B�B  �E  �D   �A�@�?�A 0 	thewindow 	theWindow�@ 0 thetab theTab�? 0 errormsg errorMsg 5�>�=�<�; . 1�: ��9�8�7�6�5�4�3�2�1�0 o q�/�.�-�, ��+�*�)�(�' � � ��& ��% ��$ ��#�"�!� �� ���������> 0 urllist urlList
�= .misccurdldt    ��� null
�< 
TEXT�; 0 	datestamp 	dateStamp�: 0 	notetitle 	noteTitle
�9 .miscactvnull��� ��� null
�8 
cwin
�7 
kocl
�6 
cobj
�5 .corecnte****       ****
�4 
CrTb
�3 
pnam�2 0 tabtitle tabTitle
�1 
URL �0 0 taburl tabUrl
�/ 
ret �. 0 tabinfo tabInfo�- 0 errormsg errorMsg�,  �+ 0 erromsg erroMsg
�* .ascrcmnt****      � ****
�) 
ascr
�( 
txdl�' 0 olddelim oldDelim
�& 
ctxt
�% 
prmt
�$ 
dfnm
�# 
dflc
�" afdmdesk
�! .earsffdralis        afdr�  
� .sysonwflfile    ��� null� 0 savefile saveFile
� 
perm
� .rdwropenshor       file� 0 savefiel saveFiel
� 
refn
� .rdwrwritnull���     ****�  
� .rdwrclosnull���     ****�CMjvE�O*j �&E�Ob   �%�%�%E�O� �*j O y*�-[��l kh   P H��-[��l kh ��,E�O�a ,E` Oa �%a %_ %_ %_ %E` O_ �6GOP[OY��OPW X  a _ %j OP[OY��UO_ a ,E` Oa _ a ,FOa �%a  %_ %_ %�%a !&E�O_ _ a ,FOa " /*j O*a #a $a %b   a &%a 'a (j )a * +E` ,UOa - 1_ ,a .el /E` 0O �a 1_ ,l 2W X 3 hO_ ,j 4Uascr  ��ޭ