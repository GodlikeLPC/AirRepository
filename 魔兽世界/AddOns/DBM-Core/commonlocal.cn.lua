-- CL.Core
-- Diablohu(diablohudream@gmail.com)
-- yleaf(yaroot@gmail.com)
-- Mini Dragon(projecteurs@gmail.com) <流浪者酒馆-Brilla@金色平原> 20220808

if GetLocale() ~= "zhCN" then return end
if not DBM_COMMON_L then DBM_COMMON_L = {} end

local CL = DBM_COMMON_L

-- 基本
CL.NONE								= "无"
CL.RANDOM							= "随机"
CL.NEXT								= "下一个 %s"
CL.COOLDOWN							= "%s 冷却"
CL.UNKNOWN							= "未知"
CL.INCOMING							= "%s 即将到来"
CL.INTERMISSION						= "转场"
CL.NO_DEBUFF						= "没有 %s"
CL.ALLY								= "队友"
CL.ALLIES							= "人群"
CL.SAFE								= "安全"
CL.NOTSAFE							= "不安全"
CL.SEASONAL							= "季节性"
-- 移动/方位
CL.LEFT								= "左"
CL.RIGHT							= "右"
CL.BOTH								= "两边"
CL.BEHIND							= "后面"
CL.BACK								= "后"
CL.SIDE								= "旁边"
CL.TOP								= "上"
CL.BOTTOM							= "下"
CL.MIDDLE							= "中"
CL.FRONT							= "前"
CL.EAST								= "东"
CL.WEST								= "西"
CL.NORTH							= "北"
CL.SOUTH							= "南"
CL.SHIELD							= "护盾"
CL.PILLAR							= "柱子"
CL.SHELTER							= "遮挡"
CL.EDGE								= "房间边缘"
CL.FAR_AWAY							= "远离"
CL.PIT								= "洞"
-- 机制
CL.BOMB								= "炸弹"
CL.BOMBS							= "炸弹"
CL.ORB								= "球"
CL.ORBS								= "球"
CL.RING								= "环"
CL.RINGS							= "环"
CL.CHEST							= "奖励宝箱"
CL.ADD								= "小怪"
CL.ADDS								= "小怪"
CL.BIG_ADD							= "大怪"
CL.BOSS								= "Boss"
CL.ENEMIES							= "Enemies"
CL.BREAK_LOS						= "卡视角"
CL.RESTORE_LOS						= "恢复视角"
CL.BOSSTOGETHER						= "拉近Boss"
CL.BOSSAPART						= "拉开Boss"
CL.MINDCONTROL						= "心控"
CL.TANKCOMBO						= "坦克连击"
CL.TANKCOMBOC						= "坦克连击 (%s)"
CL.AOEDAMAGE						= "AOE 伤害"
CL.GROUPSOAK						= "群体吸收"
CL.GROUPSOAKS						= "群体吸收"
