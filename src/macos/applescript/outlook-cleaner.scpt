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
msg  � o   ) *���� 0 myfolder myFolder � o      ���� 0 themessages theMessages �  � � � r   / 2 � � � m   / 0����   � o      ���� (0 permanentlydeleted permanentlyDeleted �  � � � X   3 � ��� � � Q   C � � � � � k   F � � �  � � � r   F K � � � n   F I � � � 1   G I��
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
radd � o   X Y���� 0 	thesender 	theSender � o      ���� 0 fromaddress fromAddress �  � � � l  ^ ^��������  ��  ��   �  � � � O   ^ j � � � r   b i � � � m   b c��
�� boovtrue � 1   c h��
�� 
pRed � o   ^ _���� 0 
themessage 
theMessage �  � � � l  k k��������  ��  ��   �  ��� � Z   k � � ����� � ?   k n � � � o   k l���� 0 
messageage 
messageAge � o   l m���� 0 deletecutoff deleteCutoff � k   q | � �  � � � I  q v�� ���
�� .MSOEpdelnull���     msg  � o   q r���� 0 
themessage 
theMessage��   �  ��� � r   w | � � � [   w z � � � o   w x���� (0 permanentlydeleted permanentlyDeleted � m   x y����  � o      ���� (0 permanentlydeleted permanentlyDeleted��  ��  ��  ��   � R      �� ���
�� .ascrerr ****      � **** � o      ���� 0 errormsg errorMsg��   � k   � � � �  � � � I  � ��� ���
�� .ascrcmnt****      � **** � b   � � � � � m   � � � � � � �  E r r o r :   � o   � ����� 0 errormsg errorMsg��   �  ��� � I  � ����� �
�� .sysonotfnull��� ��� TEXT��   � �� � �
�� 
appr � m   � � � � � � � 
 E R R O R � �� ���
�� 
subt � o   � ����� 0 errormsg errorMsg��  ��  �� 0 
themessage 
theMessage � o   6 7���� 0 themessages theMessages �  ��� � Z   � � � ����� � ?   � � � � � o   � ����� (0 permanentlydeleted permanentlyDeleted � m   � �����   � I  � ���~ �
� .sysonotfnull��� ��� TEXT�~   � �} � �
�} 
appr � l  � � ��|�{ � b   � � � � � m   � � � � � � � " O u t l o o k   a c c o u n t :   � o   � ��z�z  0 theaccountname theAccountName�|  �{   � �y ��x
�y 
subt � l  � � ��w�v � b   � � � � � b   � � � � � m   � � � � � � � ( P e r m a n e n t l y   d e l e t e d   � o   � ��u�u (0 permanentlydeleted permanentlyDeleted � m   � � � � � � �    m e s s a g e s�w  �v  �x  ��  ��  ��   l m     � ��                                                                                  OPIM  alis    N  Macintosh HD                   BD ����Microsoft Outlook.app                                          ����            ����  
 cu             Applications  %/:Applications:Microsoft Outlook.app/   ,  M i c r o s o f t   O u t l o o k . a p p    M a c i n t o s h   H D  "Applications/Microsoft Outlook.app  / ��  ��   W  � � � l     �t�s�r�t  �s  �r   �  � � � i     � � � I      �q ��p�q 0 cleanfolder cleanFolder �  � � � o      �o�o  0 theaccountname theAccountName �  � � � o      �n�n 0 
thefolders 
theFolders �  ��m � o      �l�l $0 deletecutoffdays deleteCutoffDays�m  �p   � k     � � �  � � � r      � � � l     ��k�j � I    �i�h�g
�i .misccurdldt    ��� null�h  �g  �k  �j   � o      �f�f 	0 today   �  � � � r     �  � ]     o    	�e�e $0 deletecutoffdays deleteCutoffDays 1   	 
�d
�d 
days  o      �c�c 0 deletecutoff deleteCutoff � �b O    � k    �  r    !	
	 6    l   �a�` 4   �_
�_ 
Eact m    �^�^ �a  �`   =    1    �]
�] 
pnam o    �\�\  0 theaccountname theAccountName
 o      �[�[ 0 
theaccount 
theAccount �Z X   " ��Y Q   2 � k   5 r  r   5 ; n   5 9 4   6 9�X
�X 
cFld o   7 8�W�W 0 thefoldername theFolderName o   5 6�V�V 0 
theaccount 
theAccount o      �U�U 0 myfolder myFolder   r   < A!"! n   < ?#$# 2  = ?�T
�T 
msg $ o   < =�S�S 0 myfolder myFolder" o      �R�R 0 themessages theMessages  %�Q% X   B r&�P'& k   R m(( )*) r   R W+,+ n   R U-.- 1   S U�O
�O 
rTim. o   R S�N�N 0 
themessage 
theMessage, o      �M�M 0 messagetime messageTime* /0/ r   X ]121 \   X [343 o   X Y�L�L 	0 today  4 o   Y Z�K�K 0 messagetime messageTime2 o      �J�J 0 
messageage 
messageAge0 5�I5 Z   ^ m67�H�G6 ?   ^ a898 o   ^ _�F�F 0 
messageage 
messageAge9 o   _ `�E�E 0 deletecutoff deleteCutoff7 I  d i�D:�C
�D .coredelonull���     obj : o   d e�B�B 0 
themessage 
theMessage�C  �H  �G  �I  �P 0 
themessage 
theMessage' o   E F�A�A 0 themessages theMessages�Q   R      �@;�?
�@ .ascrerr ****      � ****; o      �>�> 0 errormsg errorMsg�?   k   z �<< =>= I  z ��=?�<
�= .ascrcmnt****      � ****? b   z }@A@ m   z {BB �CC  E r r o r :  A o   { |�;�; 0 errormsg errorMsg�<  > D�:D I  � ��9�8E
�9 .sysonotfnull��� ��� TEXT�8  E �7FG
�7 
apprF l  � �H�6�5H b   � �IJI m   � �KK �LL  E R R O R   c l e a n i n g  J o   � ��4�4 0 thefoldername theFolderName�6  �5  G �3M�2
�3 
subtM o   � ��1�1 0 errormsg errorMsg�2  �:  �Y 0 thefoldername theFolderName o   % &�0�0 0 
thefolders 
theFolders�Z   m    NN�                                                                                  OPIM  alis    N  Macintosh HD                   BD ����Microsoft Outlook.app                                          ����            ����  
 cu             Applications  %/:Applications:Microsoft Outlook.app/   ,  M i c r o s o f t   O u t l o o k . a p p    M a c i n t o s h   H D  "Applications/Microsoft Outlook.app  / ��  �b   � O�/O l     �.�-�,�.  �-  �,  �/       �+PQRST�*�)�+  P �(�'�&�%�$�#�( 60 permanentlydeletemessages permanentlyDeleteMessages�' 0 cleanfolder cleanFolder
�& .aevtoappnull  �   � ****�% "0 outlookaccounts outlookAccounts�$  �#  Q �" Y�!� UV��" 60 permanentlydeletemessages permanentlyDeleteMessages�! �W� W  ��  0 theaccountname theAccountName�   U ��������������  0 theaccountname theAccountName� 	0 today  � 0 deletecutoff deleteCutoff� 0 
theaccount 
theAccount� 0 myfolder myFolder� 0 themessages theMessages� (0 permanentlydeleted permanentlyDeleted� 0 
themessage 
theMessage� 0 messagetime messageTime� 0 
messageage 
messageAge� 0 	thesender 	theSender� 0 fromaddress fromAddress� 0 errormsg errorMsgV ��� ��X��
 �	��������� �� ����� ������� � � �
� .misccurdldt    ��� null� 
� 
days
� 
EactX  
� 
pnam
�
 
cFld
�	 
msg 
� 
kocl
� 
cobj
� .corecnte****       ****
� 
rTim
� 
sndr
� 
radd
� 
pRed
� .MSOEpdelnull���     msg �  0 errormsg errorMsg��  
�� .ascrcmnt****      � ****
�� 
appr
�� 
subt�� 
�� .sysonotfnull��� ��� TEXT� �*j  E�O�� E�O� �*�k/�[�,\Z�81E�O���/E�O��-E�OjE�O t�[��l kh  ?��,E�O��E�O��,E�O��,E�O� 	e*a ,FUO�� �j O�kE�Y hW "X  a �%j O*a a a �a  [OY��O�j  *a a �%a a �%a %a  Y hUR �� �����YZ���� 0 cleanfolder cleanFolder�� ��[�� [  ��������  0 theaccountname theAccountName�� 0 
thefolders 
theFolders�� $0 deletecutoffdays deleteCutoffDays��  Y ����������������������������  0 theaccountname theAccountName�� 0 
thefolders 
theFolders�� $0 deletecutoffdays deleteCutoffDays�� 	0 today  �� 0 deletecutoff deleteCutoff�� 0 
theaccount 
theAccount�� 0 thefoldername theFolderName�� 0 myfolder myFolder�� 0 themessages theMessages�� 0 
themessage 
theMessage�� 0 messagetime messageTime�� 0 
messageage 
messageAge�� 0 errormsg errorMsgZ ����N��X��������������������B����K������
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
�j Y h[OY��W "X  �%j O*a a �%a �a  [OY��US ��\����]^��
�� .aevtoappnull  �   � ****\ k     P__  
``  !����  ��  ��  ] ����  0 theaccountname theAccountName^     �������������� 4 =�� G Q�� �� "0 outlookaccounts outlookAccounts
�� 
kocl
�� 
cobj
�� .corecnte****       ****�� 60 permanentlydeletemessages permanentlyDeleteMessages
�� 
TEXT�� 0 cleanfolder cleanFolder�� Q�����vE�O F�[��l kh  *�k+ 	O��&�  *��kvlm+ Y ��&�  *��kvlm+ Y h[OY��T ��a�� a      �*  �)   ascr  ��ޭ