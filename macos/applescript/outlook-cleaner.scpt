FasdUAS 1.101.10   ��   ��    k             l     ��  ��    s m Inspired by: https://hackernoon.com/automated-inbox-cleansing-with-outlook-2016-and-applescript-49cf4c4422fa     � 	 	 �   I n s p i r e d   b y :   h t t p s : / / h a c k e r n o o n . c o m / a u t o m a t e d - i n b o x - c l e a n s i n g - w i t h - o u t l o o k - 2 0 1 6 - a n d - a p p l e s c r i p t - 4 9 c f 4 c 4 4 2 2 f a   
  
 l     ��  ��    U O set outlookAccounts to {"Sensory 5", "TransWorld", "TW System Services", "GT"}     �   �   s e t   o u t l o o k A c c o u n t s   t o   { " S e n s o r y   5 " ,   " T r a n s W o r l d " ,   " T W   S y s t e m   S e r v i c e s " ,   " G T " }      l     ����  r         J            m        �    S e n s o r y   5      m       �    T r a n s W o r l d   ��  m       �   $ T W   S y s t e m   S e r v i c e s��    o      ���� "0 outlookaccounts outlookAccounts��  ��       !   l     ��������  ��  ��   !  " # " l   # $���� $ X    # %�� & % I    �� '���� 60 permanentlydeletemessages permanentlyDeleteMessages '  (�� ( o    ����  0 theaccountname theAccountName��  ��  ��  0 theaccountname theAccountName & o    ���� "0 outlookaccounts outlookAccounts��  ��   #  ) * ) l     ��������  ��  ��   *  + , + i      - . - I      �� /���� 60 permanentlydeletemessages permanentlyDeleteMessages /  0�� 0 o      ����  0 theaccountname theAccountName��  ��   . k     � 1 1  2 3 2 r      4 5 4 l     6���� 6 I    ������
�� .misccurdldt    ��� null��  ��  ��  ��   5 o      ���� 	0 today   3  7 8 7 r     9 : 9 ]     ; < ; m    	����  < 1   	 
��
�� 
days : o      ���� 0 deletecutoff deleteCutoff 8  = > = l   ��������  ��  ��   >  ?�� ? O    � @ A @ k    � B B  C D C r    ! E F E 6    G H G l    I���� I 4   �� J
�� 
Eact J m    ���� ��  ��   H =    K L K 1    ��
�� 
pnam L o    ����  0 theaccountname theAccountName F o      ���� 0 
theaccount 
theAccount D  M N M r   " ( O P O n   " & Q R Q 4   # &�� S
�� 
cFld S m   $ % T T � U U  D e l e t e d   I t e m s R o   " #���� 0 
theaccount 
theAccount P o      ���� 0 myfolder myFolder N  V W V r   ) . X Y X n   ) , Z [ Z 2  * ,��
�� 
msg  [ o   ) *���� 0 myfolder myFolder Y o      ���� 0 themessages theMessages W  \ ] \ r   / 2 ^ _ ^ m   / 0����   _ o      ���� (0 permanentlydeleted permanentlyDeleted ]  ` a ` X   3 � b�� c b Q   C � d e f d k   F s g g  h i h r   F K j k j n   F I l m l 1   G I��
�� 
rTim m o   F G���� 0 
themessage 
theMessage k o      ���� 0 messagetime messageTime i  n o n r   L Q p q p \   L O r s r o   L M���� 	0 today   s o   M N���� 0 messagetime messageTime q o      ���� 0 
messageage 
messageAge o  t u t r   R W v w v n   R U x y x 1   S U��
�� 
sndr y o   R S���� 0 
themessage 
theMessage w o      ���� 0 	thesender 	theSender u  z { z r   X ] | } | n   X [ ~  ~ 1   Y [��
�� 
radd  o   X Y���� 0 	thesender 	theSender } o      ���� 0 fromaddress fromAddress {  � � � l  ^ ^��������  ��  ��   �  ��� � Z   ^ s � ����� � ?   ^ a � � � o   ^ _���� 0 
messageage 
messageAge � o   _ `���� 0 deletecutoff deleteCutoff � k   d o � �  � � � I  d i�� ���
�� .MSOEpdelnull���     msg  � o   d e���� 0 
themessage 
theMessage��   �  ��� � r   j o � � � [   j m � � � o   j k���� (0 permanentlydeleted permanentlyDeleted � m   k l����  � o      ���� (0 permanentlydeleted permanentlyDeleted��  ��  ��  ��   e R      �� ���
�� .ascrerr ****      � **** � o      ���� 0 errormsg errorMsg��   f k   { � � �  � � � I  { ��� ���
�� .ascrcmnt****      � **** � b   { � � � � m   { ~ � � � � �  E r r o r :   � o   ~ ���� 0 errormsg errorMsg��   �  ��� � I  � ����� �
�� .sysonotfnull��� ��� TEXT��   � �� � �
�� 
appr � m   � � � � � � � 
 E R R O R � �� ���
�� 
subt � o   � ����� 0 errormsg errorMsg��  ��  �� 0 
themessage 
theMessage c o   6 7���� 0 themessages theMessages a  ��� � Z   � � � ����� � ?   � � � � � o   � ����� (0 permanentlydeleted permanentlyDeleted � m   � �����   � I  � ����� �
�� .sysonotfnull��� ��� TEXT��   � �� � �
�� 
appr � l  � � ����� � b   � � � � � m   � � � � � � � " O u t l o o k   a c c o u n t :   � o   � �����  0 theaccountname theAccountName��  ��   � �� ���
�� 
subt � l  � � ����� � b   � � � � � b   � � � � � m   � � � � � � � ( P e r m a n e n t l y   d e l e t e d   � o   � ����� (0 permanentlydeleted permanentlyDeleted � m   � � � � � � �    m e s s a g e s��  ��  ��  ��  ��  ��   A m     � ��                                                                                  OPIM  alis    N  Macintosh HD                   BD ����Microsoft Outlook.app                                          ����            ����  
 cu             Applications  %/:Applications:Microsoft Outlook.app/   ,  M i c r o s o f t   O u t l o o k . a p p    M a c i n t o s h   H D  "Applications/Microsoft Outlook.app  / ��  ��   ,  � � � l     ��������  ��  ��   �  ��� � l     ��������  ��  ��  ��       �� � � ���   � ������ 60 permanentlydeletemessages permanentlyDeleteMessages
�� .aevtoappnull  �   � **** � �� .���� � ����� 60 permanentlydeletemessages permanentlyDeleteMessages�� �� ���  �  ����  0 theaccountname theAccountName��   � ����~�}�|�{�z�y�x�w�v�u�t��  0 theaccountname theAccountName� 	0 today  �~ 0 deletecutoff deleteCutoff�} 0 
theaccount 
theAccount�| 0 myfolder myFolder�{ 0 themessages theMessages�z (0 permanentlydeleted permanentlyDeleted�y 0 
themessage 
theMessage�x 0 messagetime messageTime�w 0 
messageage 
messageAge�v 0 	thesender 	theSender�u 0 fromaddress fromAddress�t 0 errormsg errorMsg � �s�r�q ��p ��o�n T�m�l�k�j�i�h�g�f�e�d ��c�b ��a�`�_ � � �
�s .misccurdldt    ��� null�r 
�q 
days
�p 
Eact �  
�o 
pnam
�n 
cFld
�m 
msg 
�l 
kocl
�k 
cobj
�j .corecnte****       ****
�i 
rTim
�h 
sndr
�g 
radd
�f .MSOEpdelnull���     msg �e 0 errormsg errorMsg�d  
�c .ascrcmnt****      � ****
�b 
appr
�a 
subt�` 
�_ .sysonotfnull��� ��� TEXT�� �*j  E�O�� E�O� �*�k/�[�,\Z�81E�O���/E�O��-E�OjE�O g�[��l kh  2��,E�O��E�O��,E�O��,E�O�� �j O�kE�Y hW "X  a �%j O*a a a �a  [OY��O�j  *a a �%a a �%a %a  Y hU � �^ ��]�\ � ��[
�^ .aevtoappnull  �   � **** � k     # � �   � �  "�Z�Z  �]  �\   � �Y�Y  0 theaccountname theAccountName �    �X�W�V�U�T�X "0 outlookaccounts outlookAccounts
�W 
kocl
�V 
cobj
�U .corecnte****       ****�T 60 permanentlydeletemessages permanentlyDeleteMessages�[ $���mvE�O �[��l kh  *�k+ [OY��ascr  ��ޭ