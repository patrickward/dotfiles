FasdUAS 1.101.10   ��   ��    k             l     ��  ��    s m Inspired by: https://hackernoon.com/automated-inbox-cleansing-with-outlook-2016-and-applescript-49cf4c4422fa     � 	 	 �   I n s p i r e d   b y :   h t t p s : / / h a c k e r n o o n . c o m / a u t o m a t e d - i n b o x - c l e a n s i n g - w i t h - o u t l o o k - 2 0 1 6 - a n d - a p p l e s c r i p t - 4 9 c f 4 c 4 4 2 2 f a   
  
 l     ����  r         J            m        �    S e n s o r y   5      m       �    T r a n s W o r l d      m       �   $ T W   S y s t e m   S e r v i c e s   ��  m       �    G T��    o      ���� "0 outlookaccounts outlookAccounts��  ��         l     ��������  ��  ��      ! " ! l  	 P #���� # X   	 P $�� % $ k    K & &  ' ( ' I    �� )���� 60 permanentlydeletemessages permanentlyDeleteMessages )  *�� * o    ����  0 theaccountname theAccountName��  ��   (  +�� + Z     K , - .�� , =    % / 0 / l    # 1���� 1 c     # 2 3 2 o     !����  0 theaccountname theAccountName 3 m   ! "��
�� 
TEXT��  ��   0 m   # $ 4 4 � 5 5  G T - I   ( 2�� 6���� 0 cleanfolder cleanFolder 6  7 8 7 o   ) *����  0 theaccountname theAccountName 8  9 : 9 J   * - ; ;  <�� < m   * + = = � > >  _ P i a z z a��   :  ?�� ? m   - .���� ��  ��   .  @ A @ =  5 : B C B l  5 8 D���� D c   5 8 E F E o   5 6����  0 theaccountname theAccountName F m   6 7��
�� 
TEXT��  ��   C m   8 9 G G � H H  S e n s o r y   5 A  I�� I I   = G�� J���� 0 cleanfolder cleanFolder J  K L K o   > ?����  0 theaccountname theAccountName L  M N M J   ? B O O  P�� P m   ? @ Q Q � R R  _ A s a n a��   N  S�� S m   B C���� ��  ��  ��  ��  ��  ��  0 theaccountname theAccountName % o    ���� "0 outlookaccounts outlookAccounts��  ��   "  T U T l     ��������  ��  ��   U  V W V i      X Y X I      �� Z���� 60 permanentlydeletemessages permanentlyDeleteMessages Z  [�� [ o      ����  0 theaccountname theAccountName��  ��   Y k     � \ \  ] ^ ] r      _ ` _ l     a���� a I    ������
�� .misccurdldt    ��� null��  ��  ��  ��   ` o      ���� 	0 today   ^  b c b r     d e d ]     f g f m    	����  g 1   	 
��
�� 
days e o      ���� 0 deletecutoff deleteCutoff c  h i h l   ��������  ��  ��   i  j�� j O    � k l k k    � m m  n o n r    ! p q p 6    r s r l    t���� t 4   �� u
�� 
Eact u m    ���� ��  ��   s =    v w v 1    ��
�� 
pnam w o    ����  0 theaccountname theAccountName q o      ���� 0 
theaccount 
theAccount o  x y x r   " ( z { z n   " & | } | 4   # &�� ~
�� 
cFld ~ m   $ %   � � �  D e l e t e d   I t e m s } o   " #���� 0 
theaccount 
theAccount { o      ���� 0 myfolder myFolder y  � � � r   ) . � � � n   ) , � � � 2  * ,��
�� 
msg  � o   ) *���� 0 myfolder myFolder � o      ���� 0 themessages theMessages �  � � � r   / 2 � � � m   / 0����   � o      ���� (0 permanentlydeleted permanentlyDeleted �  � � � X   3 � ��� � � Q   C � � � � � k   F s � �  � � � r   F K � � � n   F I � � � 1   G I��
�� 
rTim � o   F G���� 0 
themessage 
theMessage � o      ���� 0 messagetime messageTime �  � � � r   L Q � � � \   L O � � � o   L M���� 	0 today   � o   M N���� 0 messagetime messageTime � o      ���� 0 
messageage 
messageAge �  � � � r   R W � � � n   R U � � � 1   S U��
�� 
sndr � o   R S���� 0 
themessage 
theMessage � o      ���� 0 	thesender 	theSender �  � � � r   X ] � � � n   X [ � � � 1   Y [��
�� 
radd � o   X Y���� 0 	thesender 	theSender � o      ���� 0 fromaddress fromAddress �  � � � l  ^ ^��������  ��  ��   �  ��� � Z   ^ s � ����� � ?   ^ a � � � o   ^ _���� 0 
messageage 
messageAge � o   _ `���� 0 deletecutoff deleteCutoff � k   d o � �  � � � I  d i�� ���
�� .MSOEpdelnull���     msg  � o   d e���� 0 
themessage 
theMessage��   �  ��� � r   j o � � � [   j m � � � o   j k���� (0 permanentlydeleted permanentlyDeleted � m   k l����  � o      ���� (0 permanentlydeleted permanentlyDeleted��  ��  ��  ��   � R      �� ���
�� .ascrerr ****      � **** � o      ���� 0 errormsg errorMsg��   � k   { � � �  � � � I  { ��� ���
�� .ascrcmnt****      � **** � b   { � � � � m   { ~ � � � � �  E r r o r :   � o   ~ ���� 0 errormsg errorMsg��   �  ��� � I  � ����� �
�� .sysonotfnull��� ��� TEXT��   � �� � �
�� 
appr � m   � � � � � � � 
 E R R O R � �� ���
�� 
subt � o   � ����� 0 errormsg errorMsg��  ��  �� 0 
themessage 
theMessage � o   6 7���� 0 themessages theMessages �  ��� � Z   � � � ����� � ?   � � � � � o   � ����� (0 permanentlydeleted permanentlyDeleted � m   � �����   � I  � ����� �
�� .sysonotfnull��� ��� TEXT��   � �� � �
�� 
appr � l  � � ����� � b   � � � � � m   � � � � � � � " O u t l o o k   a c c o u n t :   � o   � �����  0 theaccountname theAccountName��  ��   � � ��~
� 
subt � l  � � ��}�| � b   � � � � � b   � � � � � m   � � � � � � � ( P e r m a n e n t l y   d e l e t e d   � o   � ��{�{ (0 permanentlydeleted permanentlyDeleted � m   � � � � � � �    m e s s a g e s�}  �|  �~  ��  ��  ��   l m     � ��                                                                                  OPIM  alis    N  Macintosh HD                   BD ����Microsoft Outlook.app                                          ����            ����  
 cu             Applications  %/:Applications:Microsoft Outlook.app/   ,  M i c r o s o f t   O u t l o o k . a p p    M a c i n t o s h   H D  "Applications/Microsoft Outlook.app  / ��  ��   W  � � � l     �z�y�x�z  �y  �x   �  � � � i     � � � I      �w ��v�w 0 cleanfolder cleanFolder �  � � � o      �u�u  0 theaccountname theAccountName �  � � � o      �t�t 0 
thefolders 
theFolders �  ��s � o      �r�r $0 deletecutoffdays deleteCutoffDays�s  �v   � k     � � �  � � � r      � � � l     ��q�p � I    �o�n�m
�o .misccurdldt    ��� null�n  �m  �q  �p   � o      �l�l 	0 today   �  � � � r     � � � ]     � � � o    	�k�k $0 deletecutoffdays deleteCutoffDays � 1   	 
�j
�j 
days � o      �i�i 0 deletecutoff deleteCutoff �  ��h � O    � � � � k    � � �  �  � r    ! 6    l   �g�f 4   �e
�e 
Eact m    �d�d �g  �f   =    1    �c
�c 
pnam o    �b�b  0 theaccountname theAccountName o      �a�a 0 
theaccount 
theAccount  	�`	 X   " �
�_
 Q   2 � k   5 r  r   5 ; n   5 9 4   6 9�^
�^ 
cFld o   7 8�]�] 0 thefoldername theFolderName o   5 6�\�\ 0 
theaccount 
theAccount o      �[�[ 0 myfolder myFolder  r   < A n   < ? 2  = ?�Z
�Z 
msg  o   < =�Y�Y 0 myfolder myFolder o      �X�X 0 themessages theMessages �W X   B r�V k   R m   !"! r   R W#$# n   R U%&% 1   S U�U
�U 
rTim& o   R S�T�T 0 
themessage 
theMessage$ o      �S�S 0 messagetime messageTime" '(' r   X ])*) \   X [+,+ o   X Y�R�R 	0 today  , o   Y Z�Q�Q 0 messagetime messageTime* o      �P�P 0 
messageage 
messageAge( -�O- Z   ^ m./�N�M. ?   ^ a010 o   ^ _�L�L 0 
messageage 
messageAge1 o   _ `�K�K 0 deletecutoff deleteCutoff/ I  d i�J2�I
�J .coredelonull���     obj 2 o   d e�H�H 0 
themessage 
theMessage�I  �N  �M  �O  �V 0 
themessage 
theMessage o   E F�G�G 0 themessages theMessages�W   R      �F3�E
�F .ascrerr ****      � ****3 o      �D�D 0 errormsg errorMsg�E   k   z �44 565 I  z ��C7�B
�C .ascrcmnt****      � ****7 b   z }898 m   z {:: �;;  E r r o r :  9 o   { |�A�A 0 errormsg errorMsg�B  6 <�@< I  � ��?�>=
�? .sysonotfnull��� ��� TEXT�>  = �=>?
�= 
appr> l  � �@�<�;@ b   � �ABA m   � �CC �DD  E R R O R   c l e a n i n g  B o   � ��:�: 0 thefoldername theFolderName�<  �;  ? �9E�8
�9 
subtE o   � ��7�7 0 errormsg errorMsg�8  �@  �_ 0 thefoldername theFolderName o   % &�6�6 0 
thefolders 
theFolders�`   � m    FF�                                                                                  OPIM  alis    N  Macintosh HD                   BD ����Microsoft Outlook.app                                          ����            ����  
 cu             Applications  %/:Applications:Microsoft Outlook.app/   ,  M i c r o s o f t   O u t l o o k . a p p    M a c i n t o s h   H D  "Applications/Microsoft Outlook.app  / ��  �h   � G�5G l     �4�3�2�4  �3  �2  �5       �1HIJKL�0�/�1  H �.�-�,�+�*�)�. 60 permanentlydeletemessages permanentlyDeleteMessages�- 0 cleanfolder cleanFolder
�, .aevtoappnull  �   � ****�+ "0 outlookaccounts outlookAccounts�*  �)  I �( Y�'�&MN�%�( 60 permanentlydeletemessages permanentlyDeleteMessages�' �$O�$ O  �#�#  0 theaccountname theAccountName�&  M �"�!� �����������"  0 theaccountname theAccountName�! 	0 today  �  0 deletecutoff deleteCutoff� 0 
theaccount 
theAccount� 0 myfolder myFolder� 0 themessages theMessages� (0 permanentlydeleted permanentlyDeleted� 0 
themessage 
theMessage� 0 messagetime messageTime� 0 
messageage 
messageAge� 0 	thesender 	theSender� 0 fromaddress fromAddress� 0 errormsg errorMsgN ��� ��P�� ������
�	��� ��� ���� � � �
� .misccurdldt    ��� null� 
� 
days
� 
EactP  
� 
pnam
� 
cFld
� 
msg 
� 
kocl
� 
cobj
� .corecnte****       ****
� 
rTim
�
 
sndr
�	 
radd
� .MSOEpdelnull���     msg � 0 errormsg errorMsg�  
� .ascrcmnt****      � ****
� 
appr
� 
subt� 
� .sysonotfnull��� ��� TEXT�% �*j  E�O�� E�O� �*�k/�[�,\Z�81E�O���/E�O��-E�OjE�O g�[��l kh  2��,E�O��E�O��,E�O��,E�O�� �j O�kE�Y hW "X  a �%j O*a a a �a  [OY��O�j  *a a �%a a �%a %a  Y hUJ �  �����QR���  0 cleanfolder cleanFolder�� ��S�� S  ��������  0 theaccountname theAccountName�� 0 
thefolders 
theFolders�� $0 deletecutoffdays deleteCutoffDays��  Q ����������������������������  0 theaccountname theAccountName�� 0 
thefolders 
theFolders�� $0 deletecutoffdays deleteCutoffDays�� 	0 today  �� 0 deletecutoff deleteCutoff�� 0 
theaccount 
theAccount�� 0 thefoldername theFolderName�� 0 myfolder myFolder�� 0 themessages theMessages�� 0 
themessage 
theMessage�� 0 messagetime messageTime�� 0 
messageage 
messageAge�� 0 errormsg errorMsgR ����F��P��������������������:����C������
�� .misccurdldt    ��� null
�� 
days
�� 
Eact
�� 
pnam
�� 
kocl
�� 
cobj
�� .corecnte****       ****
�� 
cFld
�� 
msg 
�� 
rTim
�� .coredelonull���     obj �� 0 errormsg errorMsg��  
�� .ascrcmnt****      � ****
�� 
appr
�� 
subt�� 
�� .sysonotfnull��� ��� TEXT�� �*j  E�O�� E�O� �*�k/�[�,\Z�81E�O w�[��l kh  B��/E�O��-E�O /�[��l kh 	��,E�O��E�O�� 
�j Y h[OY��W "X  �%j O*a a �%a �a  [OY��UK ��T����UV��
�� .aevtoappnull  �   � ****T k     PWW  
XX  !����  ��  ��  U ����  0 theaccountname theAccountNameV     �������������� 4 =�� G Q�� �� "0 outlookaccounts outlookAccounts
�� 
kocl
�� 
cobj
�� .corecnte****       ****�� 60 permanentlydeletemessages permanentlyDeleteMessages
�� 
TEXT�� 0 cleanfolder cleanFolder�� Q�����vE�O F�[��l kh  *�k+ 	O��&�  *��kvlm+ Y ��&�  *��kvlm+ Y h[OY��L ��Y�� Y      �0  �/   ascr  ��ޭ