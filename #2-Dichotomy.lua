-- ��������� DICHOTOMY  (2015)
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
--projectName = "slau_7"
projectName = "slau_10"
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
--projectName = "e313_o206_t32"
--projectName = "e2367_o1397_t137"
--projectName = "e451_o271_t30"
--projectName = "e916_o624_t89" 
--projectName = "e17039_o9853_t199"
--
--
function UnloadTier( Tier ) -- ��������� ����� Tier 
-- ����� �������� � ���� 50% ���������� �� 
-- ����� ��������� ���� ���� �������
local j,j_max,Op
local Ops={} -- ������� �������� # ����. ����� ��������� �� �� ����������������� �����
-- 
j_max=GetCountOpsOnTier(Tier) -- ����� �������� �� ����� Tier
--
if j_max < 2 then -- ��� ����� ��������� ���������� ������! 
 return -1313
end
--
 AddTier(Tier) -- ������� ������ ���� ��� Tier  
--
for j=1,j_max,1 do -- �� ���������� ����� Tier
if  j%2 == 0   -- � ������� ��������...
then 
  Op=GetOpByNumbOnTier(j,Tier) -- ����� ���������
  table.insert(Ops,Op) -- ������ ����������� ���� ���������� 
end -- ����� if
end -- ����� for
--
for j=1,#Ops,1 -- ���������� �������
do 
 MoveOpTierToTier(Ops[j],Tier+1) -- ������� ������ 
-- AddLineToTextFrame( "---" .. Tier .. "/" .. j_max .. "|" .. Ops[j] .. "=>" .. MoveOpTierToTier(Ops[j],Tier+1) .. "---" )
end -- ����� for
--
return 0
end -- ����� ������� UnloadTiers()


local function Visual() -- ������������ ��������� ���
--AddLineToTextFrame("=====================================")  
PutTiersToTextFrame() 
ClearDiagrTiers() 
PutParamsTiers() 
DrawDiagrTiers()
DelayMS(100)
end -- ����� ������� Visual()


-- MAIN - ������� -------------------------------------
--===================================
--
ClearTextFrame()
--
WidthMax=10 -- max ������ ���
WidthMax = tonumber ( InputDialog( "���������� ������ ��� ", "������� ����� ������ ���� ��� ������", tostring( WidthMax  )))
OutLine ( "������ WidthMax= " .. WidthMax  )
DelayMS( -3  )-- �������� 3 ���
--
--ReadEdges(  projectName .. ".gv" )  -- ������ ���� �������� �����
--
CreateTiersByEdges(  projectName .. ".gv" )  -- ������� ��� �� ���
--
Visual() -- ������������ ��������� ���
--
DelayMS( -1 )
------------------------------------------------------------------------
------------------------------------------------------------------------
nTiers=GetCountTiers() -- ����� ����� ������
--
CountMovesZeroing() -- �������� ����� �����������
--
while GetCountOpsOnTier(GetTierFirstMaxOps(1,nTiers)) > WidthMax do -- ���� ������ > WidthMax
 nOps=GetCountOps() -- ����� ����� ����������
 print( nOps .. "/" .. nTiers )
--
 AverOpsByTier=nOps / nTiers
 print( AverOpsByTier )
--
 UnloadTier( GetTierFirstMaxOps(1,nTiers) ) -- ��������� MAX ������������ �����
--
 nTiers=GetCountTiers() -- ����� ����� ������
--
-- AddLineToTextFrame(GetTierFirstMaxOps(1,nTiers)) .. "-" ..  GetTierFirstMaxOps(1,nTiers) .. "=" .. GetOpsMoves()  )
 print(GetCountOpsOnTier(GetTierFirstMaxOps(1,nTiers)) .. "-" ..  GetTierFirstMaxOps(1,nTiers) .. "=" .. GetOpsMoves())
--
--Visual()  -- ������������ ��������� ��� -- ����� ���������������� ��� ��������� ��������
--
--SoundPlay("kuku.wav") -- ��������� ���� �� �����  
--
print(GetCountOpsOnTier(GetTierFirstMaxOps(1,nTiers)) .. "=" ..  GetTierFirstMaxOps(1,nTiers) .. "-" .. GetOpsMoves())
--
end -- ����� while GetCountOpsOnTier(...) > WidthMax 
--
SoundPlay("rooster.wav") -- ����� ���������, ��� ������ �������
--
Visual()  -- ������������ ��������� ���
--
print("\n�����������:" ..  GetOpsMoves() ) -- ����� ����� �����������
OutLine( "\n�����������:" ..  GetOpsMoves() )
--
-- ����� main
