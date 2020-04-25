-- ��������� BULLDOZER ( ver. #1-01, 2015 )
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
function SearchToOp(fromTier, toTier)
-- ���� (����� fromTier-toTier) � ���������� ����, �� ������� 
-- ����������� ����������� �������� (�� ����� -> �����. 0)
local minH=1000000000 -- ��� ������ min
local i,H,sTier
--
-- ���� �� ����� � ������� H �������, ��� ������� - averH (����.) ?
-- ���� ��� ������ � H<averH, �� ���������� 0
for i=fromTier+1,toTier -- �� ������ ���
do
H=GetCountOpsOnTier(i) -- ������ ����� i
--
if H<averH then -- ����� ������ �������� - ��� ���������!
 goto succ end -- ����� �� �����, ��� ����� ���� ���� ������  
--
end -- ����� ����� �� i
-- 
-- ���� return �� �������. � �������, ���� ��� ��������� � do/end 
do return 0 end -- ��� �� ������ ����� � H<averH...
::succ:: -- ����� ���� ���� ���� � H<averH !!!
--
--
for i=fromTier+1,toTier -- �� ������ ���
do
H=GetCountOpsOnTier(i) -- ����� ���������� �� ����� i  
--
if H>=averH -- ������ �������� = �����������!
then goto cont_i end -- ��� �� ����� ���� �� i  
--
-- ������ ������� ������� H<averH (��� ��� � �����!)
-- ���� ���� � ����������� �������
if H<minH then
 minH=H
 sTier=i -- ��� ���� c min ���������� �� ��
end -- ����� ������ min
--
::cont_i:: -- ����������� ���� 
end -- ����� �����  �� i
--
return sTier -- ���������� ���������...
--
end -- ����� ������� SearchToOp()

--------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------


local function Visual() -- ������������ ��������� ���
AddLineToTextFrame("=============================================================================")  
PutTiersToTextFrame() 
PutParamsTiers() 
ClearDiagrTiers() 
-- DelayMS( -1  )
DrawDiagrTiers()
-- DelayMS( -1  )
end -- ����� ������� Visual()

--------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------

-- MAIN - ������� -------------------------------------
--=================================
local H,iTier,j,nTiers,nOps,iOp, fromTier,toTier,newTier
--
ClearTextFrame() -- �������� ��������� ����
--
--ReadEdges(  projectName .. ".gv" )  -- ������ ���� �������� �����
--
CreateTiersByEdges( projectName .. ".gv" ) -- ������� ��� �� ���
--
Visual() -- ������������ ��������� ���
--
--print( debug.gethook(L) )
--
DelayMS( -3  )
--
nTiers=GetCountTiers() -- ����� ����� ������
nOps=GetCountOps() -- ����� ����� ���������� 
averH=1.0 * nOps / nTiers -- ������� ���. ��� 
--
print ("nTiers=" .. nTiers .. ", nOps=" .. nOps .. ", �����.����./����=" .. averH)  
--
CountMovesZeroing() -- �������� ����� �����������
--
-- ����� ������ �� ��������, ������� ���������� for 
for iTier=1,nTiers,1 -- �� ���� ������ ����� ��������
do 
--
if GetCountOpsOnTier(iTier) == 0 -- ������ ���� �����������!
then goto cont_iTier end 
--
-- ���� �� ���������� �� ����� ��������� repeat/until, ���
-- ������� ������� ����� ���������� (��� � Lua �����������)
j=1 -- ������ ����� �� ���������� �� ����� iTier
repeat 
 iOp=GetOpByNumbOnTier (j,iTier) -- ����� ���������
 fromTier=GetMinTierMaybeOp (iOp) -- '����' ���������� iOp
 toTier=GetMaxTierMaybeOp (iOp) -- '���' ���������� iOp
--
-- print("=-= iOp=" .. iOp .. ", fromTier=" ..  fromTier .. ", toTier=" .. toTier)
--
if toTier == fromTier then -- ���� �������� ����������� "����" ������...
goto cont_j end
--
newTier=SearchToOp(fromTier,toTier) -- �������� ����� ����������� ������������
-- ���� ��� ����������� - ������������ 0
--
if newTier == 0 then -- ���� = 0, �� ������ ������������...
goto cont_j end
--
-- ������������ ��������� iOp �� ���� newTier
print( string.format("#iOp=%d fromTier=%d toTier=%d", iOp, fromTier, toTier )) 
--
AddLineToTextFrame("\n�����������: iOp=".. iOp..", fromTier=".. fromTier ..", toTier="..toTier.. ", newTier="..newTier.." [Movies="..GetOpsMoves().."]")  
MoveOpTierToTier(iOp, newTier) -- ���������� ������������
--
Visual() -- ������������ ��������� ���
SoundPlay("kuku.wav") -- ��������� ���� �� �����  
--
::cont_j::
--
j=j+1 -- ����� ����� ��������� �� ����� iTier
--
N=GetCountOpsOnTier(iTier) -- ������� ����� ���������� �� ������ iTier
--
until j>N -- ���� �� ��������� ��� ��������� �� ������ iTier
--
::cont_iTier:: -- �� ����� ���� �� ITier
end -- ����� �� ������ ��� 
--
PutTiersToTextFrame() -- �������� ���
--
SaveEdgesVizu( "a111.txt" )
--
SaveDataLiveDiagr("a222")
--
AddLineToTextFrame( string.format("\nlWinExec: %d", lWinExec( "calc.exe", 9  ) ) )
AddLineToTextFrame( string.format("\nlWinExec: %d", lWinExec( "notepad.exe history.txt", 9  ) ) )
AddLineToTextFrame( string.format("\nlShellExecute: %d", lShellExecute("","http://vbakanov.ru/spf@home/spf@home.htm",0,0,9  ) ) )
AddLineToTextFrame( string.format("\nCreateProcess: %d", lCreateProcess("notepad.exe history.txt",0,2,1 ) ) )
--
DelayMS( -3 )
--
AddLineToTextFrame( "\nMoves=" .. GetOpsMoves() )
print( "Moves=" .. GetOpsMoves() ) -- ����� �����������
--
SoundPlay("rooster.wav") -- ����� ���������, ��� ������ �������
--
-- ����� main 

