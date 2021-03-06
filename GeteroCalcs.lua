--���������� ��������� �� ������������ ���� ������������ 
--���������������� ������� 03 (������ 2017)
--============================================================
--
--projectName = "abc_r" -- ��� ������� 
--
--projectName = "squa_equ_2"
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
--projectName = "m_matr_5"
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
projectName = "e313_o206_t32"
--projectName = "e2367_o1397_t137"
--projectName = "e451_o271_t30"
--projectName = "e916_o624_t89" 
--projectName = "e17039_o9853_t199"
--
--
-- *** �������� � ����������� (functions) *****************************************************************
--
--
function RenumbRandOps() -- ������������� ��������� � ��������� �������
-- ������� ����������� ����� ������ ����� ���������� ��� � ����������� � � Lua-������� Tiers[][]
local iTier, jTier, i, j, iOp, newOp, flag
local maxOp=0 -- ������������ ����� ���������
local K=1e6 -- �������� ������ ������� ���������� ��� �������������� (10^6)
local M=1 -- ���������� ��������� ��������� ��� �������������� (��� M=1 �������� ������� ���������� ���������... �� �����!)
local out1, out2
local n=0
--
math.randomseed( os.time() ) -- ������������� math.random 
--
for iTier=1,#Tiers do -- �� ���� ������ ���
 for jTier=1,#Tiers[iTier] do -- ���� �� ���������� �� ������ �����
  if Tiers[iTier][jTier] >= maxOp then
   maxOp = Tiers[iTier][jTier] -- ���� max (Tiers[iTier][jTier] = iOp)
end end end -- ����� if � ����� for
--
for iTier=1,#Tiers do -- �� ���� ������ ���
 for jTier=1,#Tiers[iTier] do -- ���� �� ���������� �� ������ �����
  iOp = Tiers[iTier][jTier] -- ��������� "������" ����� ��������� 
--
::cont_rand::
--
  newOp = K + math.random( 1, M * maxOp ) -- "�����" ����� ��������� (�������)
--
flag = 0 -- ��� �� ��������� newOp � ������ ?
for i=1,#Tiers do -- �� ���� ������ ���
 for j=1,#Tiers[i] do -- ���� �� ���������� �� ������ �����
  if newOp == Tiers[i][j]  then -- ����� newOp ��� ����������...
   flag = 1 -- ��������� ����
end end end -- ����� for i, for j � if newOp
--
if flag ~= 0 then -- ���� newOp ��� ������������...
 n=n+1 -- ��������� ����� "��������" math.random
 AddLineToTextFrame( "������: " .. n ) -- ������� ����� ��������
 goto cont_rand -- ��� �� ��������� ������ �������� newOp
end -- ����� if flag
--
for i=1,#Tiers do -- �� ���� ������ ���
 for j=1,#Tiers[i] do -- ���� �� ���������� �� ������ �����
  if Tiers[i][j] == iOp then -- ����� ��������� 
   Tiers[i][j] = newOp -- "�����" ����� ���������
end end end -- ����� for i, for j � if Tiers[i][j]
--
end end -- ����� for iTier=1,#Tiers � for jTier=1,#Tiers[iTier] (����� ������� )
--
for iTier=1,#Tiers do -- �� ���� ������ ���
 out1 = string.format("[RenumbRandOps] %d/%d: ", iTier, #Tiers[iTier] )
 for jTier=1,#Tiers[iTier] do -- ���� �� ���������� �� ������ �����
  Tiers[iTier][jTier] = Tiers[iTier][jTier] - K -- ��������������� ����� ��������� � ��������� [1-maxOp]
  out1 = out1 .. string.format("%d ", Tiers[iTier][jTier] )
end  -- ����� for jTier 
 AddLineToTextFrame( out1 )
end -- ����� for iTier=1,#Tiers 
end -- *** ����� ������� RenumbRandOps()  ****************************************************************
--
--
--
function FindCalcByOp( iOp ) -- ����������� ����������� ��� ������ ��������
local CalcOnCountOps = {} -- 2D-������ "������ ������������ - ����� ������. ����������"
local OpsCalcs = OpsCalcs -- ��������� ����� ���������� OpsOnCalcs[][]
local nCalcs = nCalcs -- �� ��...
local jCalc, Calc, j,  i 
local minOpsCalc = 1e9 -- math.huge �� ��������!!!
--
CalcOnCountOps[1] = {} -- ������ ������ 1
CalcOnCountOps[2] = {} -- ������ ������ 2
--
for jCalc=1,nCalcs do -- �� ���� ������������
 if CanExecOpCalc( iOp, jCalc ) > 0 then -- ����� ���������
  table.insert( CalcOnCountOps[1],  jCalc ) -- �������� � 1-� ������ ������� CalcOnCountOps[][]
  table.insert( CalcOnCountOps[2],  0 ) -- 2-� ������ ��������� ������ ��� ������������ ������������ ����� ����������
--  AddLineToTextFrame( string.format("-> iOp=%d  1-row=%d  2-row=%d",  iOp, CalcOnCountOps[ 1 ][ jCalc ], CalcOnCountOps[ 2 ][ jCalc ] ))
 end -- ����� if CanExecOpCalc( iOp, jCalc )
end -- ����� for jCalc=1,nCalcs
--  AddLineToTextFrame( string.format("-> ����� CalcOnCountOps[1/2]=%d/%d",  #CalcOnCountOps[1], #CalcOnCountOps[2] ))
--
-- � ������ CalcOnCountOps[2][�]  ���������� ����� ����������, ��� ������������� ����� �����������
for j=1,#CalcOnCountOps[1] do -- �� �������� ������� CalcOnCountOps[1][�]
 jCalc = CalcOnCountOps[1][j] -- ����������� ����� jCalc
-- ������� ����� ��� �������������� ���������� ��� ������� �� ������������
 for i=1,#OpsCalcs do -- �� ����� ����� 2D-������� OpsCalcs
  if OpsCalcs[i][jCalc] ~= 0 then -- ���� ������������ (�.�. �� 0)...
   CalcOnCountOps[2][j] = CalcOnCountOps[2][j] + 1 -- ���������...
  end -- ����� if OpsCalcs[i][jCalc]
 end -- ����� for i=1,#OpsCalcs 
--
-- ���� ����������� � min �������. ��� ���������� (������� CalcOnCountOps[2][j] �� jCalc)
-- AddLineToTextFrame( string.format("=> j=%d CalcOnCountOps[2][j]=%d minOpsCalc=%d", j, CalcOnCountOps[2][j], minOpsCalc ))
 if CalcOnCountOps[2][j] < minOpsCalc then -- ...������ ����������� �������
-- if CalcOnCountOps[2][j] <= minOpsCalc then -- ...��������� ����������� ������� 
  minOpsCalc = CalcOnCountOps[2][j]
  Calc = CalcOnCountOps[1][j]
 end -- ����� if CalcOnCountOps[2][j]
--
end -- ����� for j=1,#CalcOnCountOps[1]
--==============================================================
--out1=" Calc:  "
--out2="#Calc: "
--for j=1,#CalcOnCountOps[1] do
-- out1=out1..string.format("%04d ", CalcOnCountOps[1][j] )
-- out2=out2..string.format("%04d ", CalcOnCountOps[2][j] )
--end 
--AddLineToTextFrame( "\n#Op= "..iOp.." #Calcs= "..#CalcOnCountOps[1] )
--AddLineToTextFrame( out1 )
--AddLineToTextFrame( out2 )
--==============================================================
CalcOnCountOps = nil -- ���������� ������
--
--AddLineToTextFrame( string.format("==  FindCalcByOp() ������= %d ==", Calc))
--AddLineToTextFrame( string.format("==  FindCalcByOp() ������= %d / %d ==", minOpsCalc,Calc))
--
 return Calc -- ������� ������������� ����� ����������� ��� iOp
end -- *** ����� ������� FindCalcByOp() *************************************************************
--
--
-- 
function CopyTiersInLua() -- ������������ CreateTiersByEdges() ������ �� ��� �������� � ������ Tiers[][]
-- ������� ����� ����������� ������ ����� API-������ CreateTiersByEdges()
local iTier, nOp
local Tiers = {} -- ������� (������ ����������) �� ������ (���� ���������)
for iTier=1,GetCountTiers() do -- �� ������ ���
 Tiers[ iTier ] = {} -- ������ ������ 2D-�������
 for nOp=1,GetCountOpsOnTier( iTier ) do -- �� ���������� ������� ���������� �� ����� iTier  
  Tiers[ iTier ][ nOp ] = GetOpByNumbOnTier( nOp, iTier ) -- ����� ����� ���������
 -- AddLineToTextFrame ( string.format("#Tier=%d nOp=%d #Op=%d", iTier, nOp, Tiers[iTier][nOp] ) )  -- ������ �� �����
end end -- ����� for �� iTier � for �� nOp
--
return Tiers -- ������ ����������� Tiers[][]
--
end -- *** ����� ������� �opyTiersInLua() ********************************************************************
--
--
--

----------------------------------------------------------------------------------------------------------------------------------------------
--=== ��������� MAIN =========================================================
----------------------------------------------------------------------------------------------------------------------------------------------
--
ClearTextFrame() -- ������� ��������� ������
--
LoadFileNameParamsOps( projectName .. ".ops" )     
LoadFileNameParamsCalcs( projectName .. ".cls" )   
LoadFileNameParamsEdges( projectName .. ".med" )                                                                                      
LoadFileNameParamsVertices( projectName .. ".mvr" )
--
--AddLineToTextFrame( string.format("������� = %g", GetMetricOpByName(100,"Times")) )
--print( "������� = ".. GetMetricOpByName(100,"Times") )
--
PutParamsAll() -- ����� �������� � ����������������� ���������� ���������
--
AddLineToTextFrame ( "\n=== ����������� ===\n " )
AddLineToTextFrame ( "����� ������������= " .. GetCountCalcs() ) 
--
ReadEdges(  projectName .. ".gv" )  -- ������ ���� �������� �����
--[[
AddLineToTextFrame("\n\n���������� TestCanExecAllOpsCalcs() ����� ����������... ���-� !\n")
if ( not TestCanExecAllOpsCalcs( 0 ) )  then -- �������� ������������ ���������� �� ������������ 
 AddLineToTextFrame ( "\n...�������� � ������������� ���������� �� ������������..." )
  return
end 
--]]
AddLineToTextFrame ( "\n=== ��������� ===\n" )
AddLineToTextFrame ( "����� ����������= " .. GetCountOps() )
--
nCalcs = GetCountCalcs() -- ����� ������������
--
--PutEdgesToTextFrame() -- ����� ����� ��� ���
--
CreateTiersByEdges(  projectName .. ".gv" ) -- ������� ��� �� ���
PutTiersToTextFrame() -- ������� ��� ��� �����
 PutParamsTiers() -- ������� ��������� ���
ClearDiagrArea() -- �������� ���� �������
DrawDiagrTiers() -- ������� ��� � ���� �������� ���������
------------------------------------------------------------------------------------------------------------------------ 
Tiers = {} -- ���������� 2D-������ ��� � ������ Lua
Tiers = CopyTiersInLua() -- ��������� �� ������ CreateTiersByEdges()
------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------
--RenumbRandOps() -- ��������� ������������� ����������
------------------------------------------------------------------------------------------------------------------------
--
totalSubTiers = 0 -- ����� ����� ����������
--
nTiers = #Tiers -- ����� ����� ������ � ���
--
calcsUsedAll = 0 -- ������� ������������ ������������� ������ (�� ���� ������, ���� �������) 
--
--=== �������� ������� ���� - �� ������ ����� ��������� ��� ================
for iTier=1,nTiers do -- ���� �� ������ ��� (�� iTier) ######################################
--
 OpsCalcs = {} -- ������� ������ (���������� 1-� ������� �������� 2D-�������)
--
 subTiers = 1 -- ����� ���� �������� �� ����� iTier 
 OpsCalcs[ subTiers ] = {} -- ������� ������ ����� subTiers (����� ���������)
--
 for jCalc=1,nCalcs do -- �� ���� ��������-������������
  OpsCalcs[ subTiers ][ jCalc ] = 0 -- ���� = ����������� jCalc �� ������������ ���������
 end -- ����� for jCalc=1,nCalcs
--
 nOps = #Tiers[ iTier ]  -- ����� ���������� �� ����� iTier
 for nOp=1,nOps do -- ����� ��������� �� �����
  iOp = Tiers[ iTier ][ nOp ] -- ���������� ����� ��������� 
--
 mCalc = FindCalcByOp( iOp ) -- ���������� ����� ����������� ��� ��������� iOp
--
-- ����� �� �������� �������� ������� �����������..?
 mOps = 0 -- ��� ������������
 for i=1,subTiers do -- ����� ��� ������������� ���������� ��� ����������� j�alc
  if OpsCalcs[ i ][ mCalc ] ~= 0 then
   mOps = mOps + 1
 end end -- ����� for i � if OpsCalcs[ i ][ mCalc ]
--
 if mOps == subTiers then -- ���� ��������� ����� ��������
  subTiers = subTiers + 1
  OpsCalcs[ subTiers ] = {} -- ������� ����� �������� = ������ OpsCalcs[][]
  for jCalc = 1,nCalcs do
   OpsCalcs[ subTiers ][ jCalc ] = 0 -- ��������
  end end -- ����� if mOps � for jCalcs
-- ��� if mOps ~= subTiers ��������� �������� �� ����..!
 OpsCalcs[ subTiers ][ mCalc ] = iOp -- �������� ��������
--
end -- ����� for nOp=1,nOps
--
-- *** ������� ������ ������������� ���������� �� ������ ***************************************
--
AddLineToTextFrame( string.format("\n%d ���� (�� %d), %d ����������, %d �������� (�/��) [�����������|�������� (%% ���.���.)]:", 
                                             iTier, nTiers, #Tiers[iTier], subTiers ) )
AddLineToTextFrame( "=======================================================================" ) 
--
for i=1,subTiers do -- �� ��������� �� ������ ����� ����������
 outStr = string.format("���/����=%d: ", i)  -- ������ ��� ������
 calcsUsed = 0 -- ������� ������������ ������������ �� ���� ���������
 for j=1,nCalcs do -- �� ������������
 if OpsCalcs[i][j] ~= 0 then -- ��������� (�������������) �������� �������
  outStr = outStr .. string.format("%d|%d  ", j, OpsCalcs[i][j] )
  calcsUsed = calcsUsed + 1 -- ������� ������������ ������������
 else -- ������� (���������������) ��������
  outStr=outStr .. string.format("%d|-  ",  j )
 end end -- ����� if OpsCalcs[i][j] � for j=1,nCalcs
 AddLineToTextFrame( outStr .. string.format(" (%.1f%%)", 100 * calcsUsed / nCalcs ) )   
end -- ����� �� ���������� (for i=1,subTiers)
--
 AddLineToTextFrame( "" ) 
--
calcsUsedTier = 0 -- ������� ������������ ������������ �� ���� �����
--
for i=1,subTiers do -- �� ��������� �� ������ ����� ����������
 outStr = ""  -- ������ ��� ������
 calcsUsedSubTier = 0 -- ������� ������������ ������������ �� ���� ���������
 for j=1,nCalcs do -- �� ������������
 if OpsCalcs[i][j] ~= 0 then -- ��������� (�������������) �������� �������
  outStr=outStr .. "X" 
  calcsUsedSubTier = calcsUsedSubTier + 1 -- ������� ������������ ������������ �� ���������
 else -- ������� (���������������) ��������
  outStr=outStr .. "~"
 end end -- for j=nCalcs � if OpsCalcs[i][j]
 calcsUsedTier = calcsUsedTier + calcsUsedSubTier / nCalcs
-- ����� ���������� �� ������� ��������� � �����
 if i ~= subTiers then -- ��� �� ��������� ��������...
  AddLineToTextFrame( outStr .. string.format(" (%.1f%%)", 
                                           100 * calcsUsedSubTier / nCalcs ) )  
 else -- � ��� ���� ��� ���������..!
  AddLineToTextFrame( outStr .. string.format(" (%.1f%%); ������� �� ���/������ %.1f%%", 
                                           100 * calcsUsedSubTier / nCalcs, 
                                           100 * calcsUsedTier / subTiers ) )  
 end -- ����� if i ~= ...
--
end -- ����� �� ���������� (for i=1,subTiers)
--
OpsCalcs = nil -- ���������� ������ ������� 
--
totalSubTiers = totalSubTiers + subTiers -- ��������� ����� ����� ����������
--
calcsUsedAll = calcsUsedAll + calcsUsedTier -- ������� ������������ ������������� ������ (�� ���� ������, ���� �������)
--
SoundPlay("kuku.wav") -- ������� ���������, ��� ������ ���� ��� ��������
--
end -- ����� �� ������ ��� (�� iTier) #################################################
--
Tiers = nil -- ���������� ������ �������
--
-- *** ����� �������� ��������� ******************************************************************************
--
AddLineToTextFrame( string.format("\n-=- ����� ������= %d; ����������= %d; ������������ ������������ (�����.)= %.1f%% -=-", 
                                             nTiers, totalSubTiers, 100*calcsUsedAll / totalSubTiers ) )
--
SoundPlay("rooster.wav") -- ����� ���������, ��� ������ �������
--


