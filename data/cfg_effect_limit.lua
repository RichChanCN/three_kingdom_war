
 
-------------------  Manual Generate Begin --------------------

-------------------  Manual Generate End   --------------------
local cfg_effect_limit = {
                [1] = {
                        ['limitedTag'] = {
'buff', 
                        }, 
                        ['probability'] = {
1000, 
1000, 
1000, 
1000, 
1000, 
                        }, 
                        ['tag'] = 'limit', 
                        ['targetMode'] = 'enemy_main', 
                }, 
                [2] = {
                        ['limitedTag'] = {
'debuff', 
                        }, 
                        ['probability'] = {
1000, 
1000, 
1000, 
1000, 
1000, 
                        }, 
                        ['tag'] = 'limit', 
                        ['targetMode'] = 'friend_main', 
                }, 
                [3] = {
                        ['limitedTag'] = {
'advantageous', 
                        }, 
                        ['probability'] = {
1000, 
1000, 
1000, 
1000, 
1000, 
                        }, 
                        ['tag'] = 'limit', 
                        ['targetMode'] = 'enemy_main', 
                }, 
        }

return cfg_effect_limit
 
