
 
-------------------  Manual Generate Begin --------------------

-------------------  Manual Generate End   --------------------
local cfg_effect_status_change = {
                [1] = {
                        ['fixedValue'] = {
1, 
1, 
2, 
2, 
3, 
                        }, 
                        ['name'] = T('净化'), 
                        ['probability'] = {
1000, 
1000, 
1000, 
1000, 
1000, 
                        }, 
                        ['tag'] = 'clean', 
                        ['targetMode'] = 'friend_main', 
                        ['targetObject'] = {
'debuff', 
                        }, 
                }, 
                [2] = {
                        ['fixedValue'] = {
1, 
1, 
2, 
2, 
3, 
                        }, 
                        ['name'] = T('偷取'), 
                        ['probability'] = {
1000, 
1000, 
1000, 
1000, 
1000, 
                        }, 
                        ['tag'] = 'steal', 
                        ['targetMode'] = 'enemy_main', 
                        ['targetObject'] = {
'buff', 
                        }, 
                }, 
                [3] = {
                        ['fixedValue'] = {
1, 
1, 
2, 
2, 
3, 
                        }, 
                        ['name'] = T('复制'), 
                        ['probability'] = {
1000, 
1000, 
1000, 
1000, 
1000, 
                        }, 
                        ['tag'] = 'copy', 
                        ['targetMode'] = 'enemy_main', 
                        ['targetObject'] = {
'advantageous', 
                        }, 
                }, 
        }

return cfg_effect_status_change
 
