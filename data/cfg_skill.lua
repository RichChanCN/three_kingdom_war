
 
-------------------  Manual Generate Begin --------------------

-------------------  Manual Generate End   --------------------
local cfg_skill = {
                [1] = {
                        ['desc'] = T('基本攻击，造成100%的伤害'), 
                        ['name'] = T('普通攻击'), 
                }, 
                [2] = {
                        ['desc'] = T('造成300%伤害，与目标距离每多一列，伤害+10%'), 
                        ['effectList'] = {
'ac_4', 
                        }, 
                        ['name'] = T('冲锋'), 
                }, 
                [3] = {
                        ['desc'] = T('造成100%伤害，并使目标受到眩晕和天火'), 
                        ['effectList'] = {
'ac_1', 
'sa_1', 
                        }, 
                        ['name'] = T('陨石'), 
                        ['statusList'] = {
2, 
3, 
                        }, 
                }, 
                [4] = {
                        ['desc'] = T('使目标获得30%的防御'), 
                        ['effectList'] = {
'sa_3', 
                        }, 
                        ['name'] = T('守护'), 
                }, 
                [5] = {
                        ['desc'] = T('使目标获得30%最大生命的治疗'), 
                        ['effectList'] = {
'sa_2', 
                        }, 
                        ['name'] = T('治疗'), 
                }, 
                [6] = {
                        ['desc'] = T('造成400%的伤害'), 
                        ['effectList'] = {
'ac_7', 
                        }, 
                        ['name'] = T('重击'), 
                }, 
                [7] = {
                        ['desc'] = T('立即驱散防御状态'), 
                        ['effectList'] = {
'ac_8', 
                        }, 
                        ['name'] = T('驱散防御'), 
                }, 
                [8] = {
                        ['desc'] = T('立即驱散回血状态'), 
                        ['effectList'] = {
'ac_9', 
                        }, 
                        ['name'] = T('驱散回血'), 
                }, 
        }

return cfg_skill
 
