-- ��������� BULLDOZER ( ver. #1-02, ������ 2017)
--
--projectName = "squa_equ_2"  -- ��� ������� 
--projectName = "squa_equ_2.pred"
--
--projectName = "max-1_mass-8.pred"
--projectName = "max-2_mass-8.pred"
--
--projectName = "slau_2"
--projectName = "slau_3"
--projectName = "slau_4" 
--projectName = "slau_5"
--projectName = "slau_10"
--
--projectName = "doubling_32"
--
--projectName = "m_matr_2"
--projectName = "m_matr_3"
projectName = "m_matr_5"
--projectName = "m_matr_7"
--projectName = "m_matr_10"
--
--projectName = "m_matr_vec_2"
--projectName = "m_matr_vec_3"
--projectName = "m_matr_vec_5"
--projectName = "m_matr_vec_7"
--projectName = "m_matr_vec_10"
--
--projectName = "fibonn_10"
--projectName = "tribonn_10"
--projectName = "quadronn_10"
--
--projectName = "mnk_5"
--projectName = "mnk_10"
--projectName = "mnk_15"
--projectName = "mnk_20"
--
--projectName = "mnk-2_5"
--projectName = "mnk-2_10"
--projectName = "mnk-2_15"
--projectName = "mnk-2_20"
--
--projectName = "korr_5" 
--projectName = "korr_10"
--projectName = "korr_15"
--projectName = "korr_20"
--
--projectName = "e17_o11_t6"
--projectName = "e313_o206_t32"
--projectName = "e2367_o1397_t137"
--projectName = "e451_o271_t30"
--projectName = "e916_o624_t89" 
--projectName = "e17039_o9853_t199"
--
--
function SearchToOp_v01(fromTier, toTier)
-- ���� (����� fromTier-toTier) � ���������� ����, �� ������� 
-- ����������� ����������� �������� 
local minH=1000000000 -- ��� ������ min
local sTier=0 -- �������, ���� �� ������� �� ������ ������, �� ������� ����� ���������� ��������
local H,iTier
--
for iTier=fromTier+1,toTier do -- �� ������ ���
H=GetCountOpsOnTier(iTier) -- ����� ���������� �� ����� iTier
--
if H>=bordH then -- ������ �������� = �����������!
 goto cont_iTier  -- ��� �� ����� ���� �� iTier
end 
-- ������ ������� ������� H<bordH (��� ��� � �����!)
-- ���� ���� � ����������� �������
if H<minH then
 minH=H
 sTier=iTier -- ��� ���� c min ���������� �� ��
end -- ����� ������ min
--
::cont_iTier:: -- ����������� ���� 
end -- ����� �����  �� iTier
--
return sTier -- ���������� ���������...
--
end -- ����� ������� SearchToOp_v01()
--
--
function SearchToOp_v02(fromTier, toTier)
-- ���� (����� fromTier-toTier) � ���������� ����, �� ������� 
-- ����������� ����������� �������� 
local iTier
--
for iTier=fromTier+1,toTier do -- �� ������ ���
-- if GetCountOpsOnTier(iTier)<bordH and GetCountOpsOnTier(iTier-1)>bordH then
 if GetCountOpsOnTier(iTier)<bordH then 
   return iTier
 end -- ����� if GetCountOpsOnTier(iTier)<bordH and �
end -- ����� �����  �� iTier
--
return 0 -- �� ������� �������� �����
--
end -- ����� ������� SearchToOp_v02()
--
--
function DefOpByMaxVar(iTier)
-- ������� (������ �� �ר��) �������� � max ��������������� �� ����� iTier
local jOp, iOp,  fromTier,toTier,varTier, iOpSave,fromTierSave,toTierSave
local maxVarTier = -1000000000 -- ��� ������ ����������� ������������ ��������� �� ����� iTier
--
for jOp=GetCountOpsOnTier(iTier),1,-1 do -- jOp - ����� ��������� �� ����� iTier (������ ������)
 iOp=GetOpByNumbOnTier(jOp,iTier) -- iOp - ����� ���������
 fromTier=GetMinTierMaybeOp(iOp) -- ������� ���� ������������� ������������  iOp
 toTier=GetMaxTierMaybeOp(iOp) -- ������ ���� ������������� ������������ iOp
 varTier=toTier-fromTier -- �������������� ��������� iOp
--
 if varTier>maxVarTier then -- ���� max( varTier )
  iOpSave=iOp -- ��������� ���������� ����� ��������� � max (�� ����� iTier) ��������������
  fromTierSave=fromTier
  toTierSave=toTier
  maxVarTier=varTier
 end -- �����  if varTier>maxVarTier
 --
 end --  ����� ����� for jOp=1,(iTier)
 --
 return iOpSave,fromTierSave,toTierSave -- ������� �������� � max ��������������� � ��� ������
end -- ����� ������� DefOpByMaxVar()
--
--------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------
                                                 
local function Visual() -- ������������ ��������� ���
AddLineToTextFrame("=====================================")  
PutTiersToTextFrame() 
PutParamsTiers() 
ClearDiagrTiers() 
DrawDiagrTiers()
end -- ����� ������� Visual()
--
--------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------
-- MAIN - ������� ----------------------------------------------------------------------------
--=========================================================
local averH,H,iTier,nTiers,nOps,iOp, fromTier,toTier,newTier
--
ClearTextFrame() -- �������� ��������� ����
--
--ReadEdges(  projectName .. ".gv" )  -- ������ ���� �������� �����
--
CreateTiersByEdges(  projectName .. ".gv" ) -- ������� ��� �� ���
--
Visual() -- ������������ ��������� ���
--
DelayMS( -1 )
--
CountMovesZeroing() -- �������� ����� �����������
--
nTiers=GetCountTiers() -- ����� ����� ������
nOps=GetCountOps() -- ����� ����� ����������
averH=1.0 * nOps / nTiers -- ������� ������  ���
bordH=math.ceil(averH) -- ��������� �������� ������� ��������
--
--***************************************************
for iTier=1,nTiers-1 do -- �� ������ ����� �� 1 �� ��������������  (nTiers-1)
--
::retry_iTier:: -- ��������� ������������ ���������� ����� iTier
AddLineToTextFrame("\niTier="..iTier..', bordH='..bordH.. ", ���.="..GetCountOpsOnTier(iTier))  
--
if GetCountOpsOnTier(iTier)<bordH then  -- ������ ����� < bordH - ������ ���������� ������ !!!
 goto cont_iTier -- ����� ��������� ����� iTier
end
--
iOp,fromTier,toTier=DefOpByMaxVar(iTier) -- ���� �������� � ���������� �������������
--
if fromTier==toTier then  -- �������������� == 0 (���������� ������)
 goto cont_iTier
end
--
-- ������ ��������� ����� �������� � max( varTier ) 

newTier=SearchToOp_v02(fromTier,toTier) -- �������� ����� �����������
-- ������������ (������ ���������� newTier ������ SearchToOp
AddLineToTextFrame("newTier= "..newTier)
--
if newTier==0 then -- ������� ����, ��� ������������ ������
 goto cont_iTier
end
--
-- ���������� ������������ ��������� iOp �� ���� newTier
print( string.format("#iOp=%d fromTier=%d toTier=%d newTier=%d", iOp,fromTier,toTier,newTier)) 
AddLineToTextFrame("\n�����������: iOp=".. iOp.."("..GetTierByOp(iOp).."), fromTier=".. fromTier ..", toTier="..toTier.. ", newTier="..newTier.." ["..GetOpsMoves().."]")  
MoveOpTierToTier(iOp, newTier) -- ���������� ������������
--
Visual() -- ������������ ��������� ��� ����� ���������
SoundPlay("kuku.wav") -- ��������� ���� �� �����  
--
goto retry_iTier -- ����� ���������� �� ����� iTier ����������, ����������� ���� �����
--
::cont_iTier:: -- ����� �������� �� iTier
end -- ����� ��������� ����� (�� iTier)
--
PutTiersToTextFrame() -- �������� ���
--
print( "Moves=" .. GetOpsMoves() ) -- ����� �����������
--
SoundPlay("rooster.wav") -- ����� ���������, ��� ������ �������
--
-- ����� main       
