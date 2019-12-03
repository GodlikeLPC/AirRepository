# AirRepository


MBB.lua下55行添加以下代码 让大脚插件适配Questie任务单体插件
["Questie"] = true,
["Atlas"] = true,


#要水

/script SendChatMessage("尊贵的奥术掌控者，能否为圣光的使者制作一些魔法泉水，助我用圣光拯救更多的战友。","whisper",GetDefaultLanguage("target"),UnitName("target"))


#l无限视距

/console cameraDistanceMaxZoomFactor 4


#假死冰冻陷阱收宠宏，支持官方怀旧服，有可能需要放2下

#showtooltip 冰冻陷阱
/ClearTarget
/PetPassiveMode
/petFollow
/施放 假死
/施放 冰冻陷阱
/targetlastenemy


#雄鹰 猎豹 守护切换宏

/castsequence 雄鹰守护,猎豹守护


#标记上BB，有目标就上标记 宠物攻击 没目标就丢照明

/cast [harm] 猎人印记;照明弹
/petattack


#近战宏 字串8
这个宏的作用是： 如果目标未近身，则施放自动射击， 若目标近身，则顺次施放猛禽+摔绊，5秒后/脱离战斗/切换目标的情况下重置，同时猫鼬或者反击可用时施放相应技能

# showtooltip 猛禽一击
/castsequence reset=5 猛禽一击,摔绊,摔绊,摔绊,摔绊
/castrandom 猫鼬撕咬,反击
/cast 自动射击


#无限鹰眼
猎人可以连续释放鹰眼术 可以看遍整个地图 找怪 做任务 看刷新神技能

/cast !鹰眼术


#BB打图腾的宏

/petattack
/petattack [target=战栗图腾][target=图腾]
/petattack [target=风怒图腾][target=图腾]
/petattack [target=地缚图腾][target=图腾]
/petattack [target=根基图腾][target=图腾]
/petattack [target=灼热图腾][target=图腾]
/petattack [target=法力之泉图腾][target=图腾]


#上下马换饰品

/equipslot [mounted] 14 守护之符;
/equipslot [mounted] 13 天选者印记;
/dismount [mounted];
/equipslot [nomounted] 14 棍子上的胡萝卜;
/cast [nomounted]条纹霜刃豹缰绳;


#抢怪宏

/target 你的目标
/script SetRaidTarget("target", 6)
/cast 射击

1星 2圆 3菱 4三角 5月 6方块 7大叉 8骷髅


#无限鞭子

/cast [nochanneling]精神鞭笞


