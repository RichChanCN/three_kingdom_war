
 
-------------------  Manual Generate Begin --------------------

-------------------  Manual Generate End   --------------------
local cfg_effect_status_append = {
                [1] = {
                        ['name'] = T('附加燃烧'), 
                        ['probability'] = {
1000, 
1000, 
1000, 
1000, 
1000, 
                        }, 
                        ['statusList'] = {
2, 
                        }, 
                        ['tag'] = 'status_append', 
                        ['targetMode'] = 'enemy_all', 
                        ['timing'] = 12, 
                }, 
                [2] = {
                        ['name'] = T('附加治疗'), 
                        ['probability'] = {
1000, 
1000, 
1000, 
1000, 
1000, 
                        }, 
                        ['statusList'] = {
1, 
                        }, 
                        ['tag'] = 'status_append', 
                        ['targetMode'] = 'friend_all', 
                        ['timing'] = 15, 
                }, 
                [3] = {
                        ['name'] = T('附加守护状态'), 
                        ['probability'] = {
1000, 
1000, 
1000, 
1000, 
1000, 
                        }, 
                        ['statusList'] = {
4, 
                        }, 
                        ['tag'] = 'status_append', 
                        ['targetMode'] = 'friend_all', 
                        ['timing'] = 15, 
                }, 
                [4] = {
                        ['name'] = T('附加软泥状态'), 
                        ['probability'] = {
1000, 
1000, 
1000, 
1000, 
1000, 
                        }, 
                        ['statusList'] = {
5, 
                        }, 
                        ['tag'] = 'status_append', 
                        ['targetMode'] = 'friend_all', 
                        ['timing'] = 15, 
                }, 
        }

return cfg_effect_status_append
 
