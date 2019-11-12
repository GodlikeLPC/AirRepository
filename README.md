# AirRepository


MBB.lua下55行添加以下代码 让大脚插件适配Questie任务单体插件
["Questie"] = true,
["Atlas"] = true,


#要水

/script SendChatMessage("尊贵的奥术掌控者，能否为圣光的使者制作一些魔法泉水，助我用圣光拯救更多的战友。","whisper",GetDefaultLanguage("target"),UnitName("target"))


#l无限视距

/console cameraDistanceMaxZoomFactor 4


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


