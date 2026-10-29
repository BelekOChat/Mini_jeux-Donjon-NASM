section .text
    global _start

struc Potion
    .name: resb 50
    .heal: resd 1
    .quantity: resd 1
endstruc

struc Inventaire
    .potion: resb Potion_size
endstruc

struc Player
    .name: resb 50
    .pv: resd 1
    .pv_max: resd 1
    .level: resd 1
    .xp: resd 1
    .level_up: resd 1
    .attack: resd 1

    .inventaire: resb Inventaire_size
endstruc

struc Monster
    .name: resb 50
    .pv: resd 1
    .pv_max: resd 1
    .xp_min: resd 1
    .xp_max: resd 1
    .attack: resd 1
endstruc

_start:
    ;Demander le nom du joueurs
    mov edx, len_ask_name
    mov ecx, ask_name
    mov ebx, 1
    mov eax, 4
    int 0x80

    ;Stocker le nom du joueurs
    mov edx, 50
    mov ecx, player + Player.name
    mov ebx, 0
    mov eax, 3
    int 0x80

    ; Vérifier que le nom a bien été lu
    cmp eax, 0
    jle _end

    ; Vérifier si le dernier caractère est '\n'
    cmp byte [player + Player.name + eax - 1], 10
    jne _save_name_length

    ; Retirer le retour à la ligne de la longueur
    dec eax

    _save_name_length:
        mov [len_player_name], eax

    ;Afficher 'Bonjour '
    mov edx, len_print_player_name
    mov ecx, print_player_name
    mov ebx, 1
    mov eax, 4
    int 0x80

    ;Afficher le nom du joueurs apres le Bonjour
    mov edx, 50
    mov ecx, player + Player.name
    mov ebx, 1
    mov eax, 4
    int 0x80

    jmp _game_1

_show_statistique:
    ;Afficher '========= Statistique ========='
    mov edx, len_statistique
    mov ecx, statistique
    mov ebx, 1
    mov eax, 4
    int 0x80

    ;Afficher le nom du joueurs
    mov edx, len_print_player_name_stat
    mov ecx, print_player_name_stat
    mov ebx, 1
    mov eax, 4
    int 0x80
    
    mov edx, [len_player_name]
    mov ecx, player + Player.name
    mov ebx, 1
    mov eax, 4
    int 0x80

    ;Afficher le niveaux du joueurs
    mov edx, len_print_player_level
    mov ecx, print_player_level
    mov ebx, 1
    mov eax, 4
    int 0x80

    mov eax, [player + Player.level]

    xor edx, edx
    mov ebx, 10
    div ebx

    add al, '0'
    add dl, '0'

    mov [level_buffer], al
    mov [level_buffer + 1], dl

    mov edx, 3
    mov ecx, level_buffer
    mov ebx, 1
    mov eax, 4
    int 0x80

    ;Afficher l'xp du joueur 
    mov edx, len_print_xp_player
    mov ecx, print_xp_player
    mov ebx, 1
    mov eax, 4
    int 0x80

    mov eax, [player + Player.xp]

    xor edx, edx
    mov ebx, 100
    div ebx

    mov ecx, eax
    mov eax, edx

    xor edx, edx
    mov ebx, 10
    div ebx

    add cl, '0'
    add al, '0'
    add dl, '0'

    mov [xp_buffer], cl
    mov [xp_buffer + 1], al
    mov [xp_buffer + 2], dl

    mov edx, 3
    mov ecx, xp_buffer
    mov ebx, 1
    mov eax, 4
    int 0x80

    mov edx, len_print_slash
    mov ecx, print_slash
    mov ebx, 1
    mov eax, 4
    int 0x80

    mov eax, [player + Player.level_up]

    xor edx, edx
    mov ebx, 100
    div ebx

    mov ecx, eax
    mov eax, edx

    xor edx, edx
    mov ebx, 10
    div ebx

    add cl, '0'
    add al, '0'
    add dl, '0'

    mov [xp_buffer], cl
    mov [xp_buffer + 1], al
    mov [xp_buffer + 2], dl

    mov edx, 3
    mov ecx, xp_buffer
    mov ebx, 1
    mov eax, 4
    int 0x80

    ;Afficher l'attaque du joueur
    mov edx, len_print_attack_player
    mov ecx, print_attack_player
    mov ebx, 1
    mov eax, 4
    int 0x80

    mov eax, [player + Player.attack]

    xor edx, edx
    mov ebx, 10
    div ebx

    add al, '0'
    add dl, '0'

    mov [attack_buffer], al
    mov [attack_buffer + 1], dl

    mov edx, 2
    mov ecx, attack_buffer
    mov ebx, 1
    mov eax, 4
    int 0x80

    ;Afficher le point de vie du joueur
    mov edx, len_print_player_pv
    mov ecx, print_player_pv
    mov ebx, 1
    mov eax, 4
    int 0x80

    mov eax, [player + Player.pv]

    xor edx, edx
    mov ebx, 100
    div ebx

    mov ecx, eax
    mov eax, edx

    xor edx, edx
    mov ebx, 10
    div ebx

    add cl, '0'
    add al, '0'
    add dl, '0'

    mov [pv_buffer], cl
    mov [pv_buffer + 1], al
    mov [pv_buffer + 2], dl

    mov edx, 3
    mov ecx, pv_buffer
    mov ebx, 1
    mov eax, 4
    int 0x80

    mov edx, len_print_slash
    mov ecx, print_slash
    mov ebx, 1
    mov eax, 4
    int 0x80

    mov eax, [player + Player.pv_max]

    xor edx, edx
    mov ebx, 100
    div ebx

    mov ecx, eax
    mov eax, edx

    xor edx, edx
    mov ebx, 10
    div ebx

    add cl, '0'
    add al, '0'
    add dl, '0'

    mov [pv_buffer], cl
    mov [pv_buffer + 1], al
    mov [pv_buffer + 2], dl

    mov edx, 3
    mov ecx, pv_buffer
    mov ebx, 1
    mov eax, 4
    int 0x80

    mov edx, 1
    mov ecx, newline
    mov ebx, 1
    mov eax, 4
    int 0x80

    jmp _player_choice


_game_1:
    ;Afficher 'Name + vous arivez dans la Caverne des Goblin.'
    mov edx, [len_player_name]
    mov ecx, player + Player.name
    mov ebx, 1
    mov eax, 4
    int 0x80

    mov edx, len_print_salles_1
    mov ecx, print_salles_1
    mov ebx, 1
    mov eax, 4
    int 0x80

    ;Premier combat
    jmp _print_goblin_attack

_game_2:
    ;Afficher 2 retour a la ligne 
    mov edx, 2
    mov ecx, double_newline
    mov ebx, 1
    mov eax, 4
    int 0x80

    ;Afficher 'Name + vous arivez dans la crypte des squelettes.
    mov edx, [len_player_name]
    mov ecx, player + Player.name
    mov ebx, 1
    mov eax, 4
    int 0x80

    mov edx, len_print_salles_2
    mov ecx, print_salles_2
    mov ebx, 1
    mov eax, 4
    int 0x80

    ;Deuxieme combat
    jmp _print_sqelette_attack


_print_goblin_attack:
    ;Affiche 'Un '
    mov edx, len_un
    mov ecx, un
    mov ebx, 1
    mov eax, 4
    int 0x80

    ;Affiche le nom du monstre
    mov edx, len_goblin_name
    mov ecx, goblin_name
    mov ebx, 1
    mov eax, 4
    int 0x80

    ;Affiche ' vous attaque'
    mov edx, len_attack_message
    mov ecx, attack_message
    mov ebx, 1
    mov eax, 4
    int 0x80

    jmp _player_choice

_print_sqelette_attack:
    ;Affiche 'Un '
    mov edx, len_un
    mov ecx, un
    mov ebx, 1
    mov eax, 4
    int 0x80

    ;Affiche le nom du monstre
    mov edx, len_squelette_name
    mov ecx, squelette_name
    mov ebx, 1
    mov eax, 4
    int 0x80

    ;Affiche ' vous attaque'
    mov edx, len_attack_message
    mov ecx, attack_message
    mov ebx, 1
    mov eax, 4
    int 0x80

_player_choice:
    ;Afficher le message pour connaitre ce que veux faire le joueur
    mov edx, len_what_player_choice_message
    mov ecx, what_player_choice_message
    mov ebx, 1
    mov eax, 4
    int 0x80

    ;Savoir ce que le joueur veux faire
    mov edx, 2
    mov ecx, what_player_choice
    mov ebx, 0
    mov eax, 3
    int 0x80

    cmp byte [what_player_choice], '1'
    je _verify_attack
    cmp byte [what_player_choice], '2'
    je _show_statistique
    cmp byte [what_player_choice], '3'
    je _show_potion
    cmp byte [what_player_choice], '4'
    je _verify_use_heal_potion

    jmp _player_choice

_verify_attack:
    cmp byte [nb_salles], 1
    je _attack_goblin_function
    cmp byte [nb_salles], 2
    je _attack_squelette_function

_attack_goblin_function:
    ;Enlever les pv du monstre
    mov eax, [player + Player.attack]
    sub [goblin + Monster.pv], eax

    ;Afficher 'Vous avez infliger '
    mov edx, len_player_attack
    mov ecx, player_attack
    mov ebx, 1
    mov eax, 4
    int 0x80

    mov eax, [player + Player.attack]

    xor edx, edx
    mov ebx, 10
    div ebx

    add al, '0'
    add dl, '0'

    mov [attack_buffer], al
    mov [attack_buffer + 1], dl

    ;Afficher le nombre de degat que le joueur a infliger
    mov edx, 2
    mov ecx, attack_buffer
    mov ebx, 1
    mov eax, 4
    int 0x80

    ;Affiche ' dégat'
    mov edx, len_degat
    mov ecx, degat
    mov ebx, 1
    mov eax, 4
    int 0x80

    cmp dword [goblin + Monster.pv], 0
    jle _goblin_defeated
    cmp dword [goblin + Monster.pv], 0
    jg _show_pv

_attack_squelette_function:
    mov eax, [player + Player.attack]
    sub [squelette + Monster.pv], eax

    ;Afficher 'Vous avez infliger '
    mov edx, len_player_attack
    mov ecx, player_attack
    mov ebx, 1
    mov eax, 4
    int 0x80

    mov eax, [player + Player.attack]

    xor edx, edx
    mov ebx, 10
    div ebx

    add al, '0'
    add dl, '0'

    mov [attack_buffer], al
    mov [attack_buffer + 1], dl

    ;Afficher le nombre de degat que le joueur a infliger
    mov edx, 2
    mov ecx, attack_buffer
    mov ebx, 1
    mov eax, 4
    int 0x80

    ;Affiche ' dégat'
    mov edx, len_degat
    mov ecx, degat
    mov ebx, 1
    mov eax, 4
    int 0x80

    cmp dword [squelette + Monster.pv], 0
    jle _squelette_defeated
    cmp dword [squelette + Monster.pv], 0
    jg _show_pv

_show_pv:
    ;Enlever les point de vie du joueur
    cmp dword [nb_salles], 1
    cmove eax, [goblin + Monster.attack]
    cmp dword [nb_salles], 2
    cmove eax, [squelette + Monster.attack]

    sub [player + Player.pv], eax

    ;Afficher le nombre de pv que le joueurs as 'Vous avez 100/100 Pv'
    mov edx, len_player_pv
    mov ecx, player_pv
    mov ebx, 1
    mov eax, 4
    int 0x80

    mov eax, [player + Player.pv]

    xor edx, edx
    mov ebx, 100
    div ebx

    mov ecx, eax
    mov eax, edx

    xor edx, edx
    mov ebx, 10
    div ebx

    add cl, '0'
    add al, '0'
    add dl, '0'

    mov [pv_buffer], cl
    mov [pv_buffer + 1], al
    mov [pv_buffer + 2], dl

    ;Afficher les pv actuelle du joueur
    mov edx, 3
    mov ecx, pv_buffer
    mov ebx, 1
    mov eax, 4
    int 0x80

    ;Afficher le /
    mov edx, len_print_slash
    mov ecx, print_slash
    mov ebx, 1
    mov eax, 4
    int 0x80

    mov eax, [player + Player.pv_max]

    xor edx, edx
    mov ebx, 100
    div ebx

    mov ecx, eax
    mov eax, edx

    xor edx, edx
    mov ebx, 10
    div ebx

    add cl, '0'
    add al, '0'
    add dl, '0'

    mov [pv_buffer], cl
    mov [pv_buffer + 1], al
    mov [pv_buffer + 2], dl

    ;Afficher les pv max du joueur
    mov edx, 3
    mov ecx, pv_buffer
    mov ebx, 1
    mov eax, 4
    int 0x80

    ;Afficher ' Pv'
    mov edx, len_pv
    mov ecx, pv
    mov ebx, 1
    mov eax, 4
    int 0x80

    cmp dword [nb_salles], 1
    je _show_goblin_pv
    cmp dword [nb_salles], 2
    je _show_squelette_pv


_show_goblin_pv:
    ;Afficher le nombre de Pv du goblin
    mov edx, len_le
    mov ecx, le
    mov ebx, 1
    mov eax, 4
    int 0x80

    ;Afficher le nom du monstre
    mov edx, len_goblin_name
    mov ecx, goblin_name
    mov ebx, 1
    mov eax, 4
    int 0x80

    mov edx, len_a
    mov ecx, a
    mov ebx, 1
    mov eax, 4
    int 0x80

    mov eax, [goblin + Monster.pv]

    xor edx, edx
    mov ebx, 10
    div ebx

    add al, '0'
    add dl, '0'

    mov [pv_buffer], al
    mov [pv_buffer + 1], dl

    mov edx, 2
    mov ecx, pv_buffer
    mov ebx, 1
    mov eax, 4
    int 0x80

    ;Afficher le '/'
    mov edx, len_print_slash
    mov ecx, print_slash
    mov ebx, 1
    mov eax, 4
    int 0x80

    mov eax, [goblin + Monster.pv_max]

    xor edx, edx
    mov ebx, 10
    div ebx

    add al, '0'
    add dl, '0'

    mov [pv_buffer], al
    mov [pv_buffer + 1], dl

    mov edx, 2
    mov ecx, pv_buffer
    mov ebx, 1
    mov eax, 4
    int 0x80

    mov edx, len_pv
    mov ecx, pv
    mov ebx, 1
    mov eax, 4
    int 0x80

    jmp _player_choice

_show_squelette_pv:
    ;Afficher le nombre de Pv du squelette
    mov edx, len_le
    mov ecx, le
    mov ebx, 1
    mov eax, 4
    int 0x80

    ;Afficher le nom du monstre
    mov edx, len_squelette_name
    mov ecx, squelette_name
    mov ebx, 1
    mov eax, 4
    int 0x80

    mov edx, len_a
    mov ecx, a
    mov ebx, 1
    mov eax, 4
    int 0x80

    mov eax, [squelette + Monster.pv]

    xor edx, edx
    mov ebx, 10
    div ebx

    add al, '0'
    add dl, '0'

    mov [pv_buffer], al
    mov [pv_buffer + 1], dl

    mov edx, 2
    mov ecx, pv_buffer
    mov ebx, 1
    mov eax, 4
    int 0x80

    ;Afficher le '/'
    mov edx, len_print_slash
    mov ecx, print_slash
    mov ebx, 1
    mov eax, 4
    int 0x80

    mov eax, [squelette + Monster.pv_max]

    xor edx, edx
    mov ebx, 10
    div ebx

    add al, '0'
    add dl, '0'

    mov [pv_buffer], al
    mov [pv_buffer + 1], dl

    mov edx, 2
    mov ecx, pv_buffer
    mov ebx, 1
    mov eax, 4
    int 0x80

    mov edx, len_pv
    mov ecx, pv
    mov ebx, 1
    mov eax, 4
    int 0x80

    jmp _player_choice

_goblin_defeated:
    ;Afficher que le monstre est mort
    mov edx, len_monster_die
    mov ecx, monster_die
    mov ebx, 1
    mov eax, 4
    int 0x80

    mov edx, len_goblin_name
    mov ecx, goblin_name
    mov ebx, 1
    mov eax, 4
    int 0x80

    inc dword [nb_salles]

    cmp dword [nb_salles], 2
    je _game_2


    jmp _end

_squelette_defeated:
    ;Afficher que le monstre est mort
    mov edx, len_monster_die
    mov ecx, monster_die
    mov ebx, 1
    mov eax, 4
    int 0x80

    mov edx, len_squelette_name
    mov ecx, squelette_name
    mov ebx, 1
    mov eax, 4
    int 0x80

    inc dword [nb_salles]

    cmp dword [nb_salles], 3
    je _game_2

_show_potion:
    ;Afficher '========= Potions ========='
    mov edx, len_show_potions
    mov ecx, show_potions
    mov ebx, 1
    mov eax, 4
    int 0x80

    ;Afficher le nom de la potion
    mov edx, len_potion
    mov ecx, potion
    mov ebx, 1
    mov eax, 4
    int 0x80

    mov edx, len_potion_heal_1
    mov ecx, potion_heal_1
    mov ebx, 1
    mov eax, 4
    int 0x80

    ;Afficher le heal dela potion
    mov eax, [player + Player.inventaire + Inventaire.potion + Potion.heal]

    xor edx, edx
    mov ebx, 10
    div ebx

    add al, '0'
    add dl, '0'

    mov [potion_buffer], al
    mov [potion_buffer + 1], dl

    mov edx, 2
    mov ecx, potion_buffer
    mov ebx, 1
    mov eax, 4
    int 0x80

    mov edx, len_potion_heal_2
    mov ecx, potion_heal_2
    mov ebx, 1
    mov eax, 4
    int 0x80

    mov edx, len_double_point
    mov ecx, double_point
    mov ebx, 1
    mov eax, 4
    int 0x80

    ;Afficher le nombre de potion
    mov eax, [player + Player.inventaire + Inventaire.potion + Potion.quantity]

    xor edx, edx
    mov ebx, 10
    div ebx

    add al, '0'
    add dl, '0'

    mov [potion_buffer], al
    mov [potion_buffer + 1], dl

    mov edx, 2
    mov ecx, potion_buffer
    mov ebx, 1
    mov eax, 4
    int 0x80

    ;Affiche une novelle ligne
    mov edx, 1
    mov ecx, newline
    mov ebx, 1
    mov eax, 4
    int 0x80

    jmp _player_choice

_use_heal_potion:
    ;Ajoute les pv de la potion au joueur
    mov eax, [player + Player.inventaire + Inventaire.potion + Potion.heal]
    add dword [player + Player.pv], eax

    ;Affiche que le joueur a bien utiliser sa potion
    mov edx, len_print_potion_used
    mov ecx, print_potion_used
    mov ebx, 1
    mov eax, 4
    int 0x80

    ;Afficher les nouveaux pv du joueur
    mov edx, len_player_pv
    mov ecx, player_pv
    mov ebx, 1
    mov eax, 4
    int 0x80

    mov eax, [player + Player.pv]

    xor edx, edx
    mov ebx, 100
    div ebx

    mov ecx, eax
    mov eax, edx

    xor edx, edx
    mov ebx, 10
    div ebx

    add cl, '0'
    add al, '0'
    add dl, '0'

    mov [pv_buffer], cl
    mov [pv_buffer + 1], al
    mov [pv_buffer + 2], dl

    mov edx, 3
    mov ecx, pv_buffer
    mov ebx, 1
    mov eax, 4
    int 0x80

    ;Afficher le '/'
    mov edx, len_print_slash
    mov ecx, print_slash
    mov ebx, 1
    mov eax, 4
    int 0x80

    ;Afficher les pv max du joueur
    mov eax, [player + Player.pv_max]

    xor edx, edx
    mov ebx, 100
    div ebx

    mov ecx, eax
    mov eax, edx

    xor edx, edx
    mov ebx, 10
    div ebx

    add cl, '0'
    add al, '0'
    add dl, '0'

    mov [pv_buffer], cl
    mov [pv_buffer + 1], al
    mov [pv_buffer + 2], dl

    mov edx, 3
    mov ecx, pv_buffer
    mov ebx, 1
    mov eax, 4
    int 0x80

    ;Afficher ' Pv'
    mov edx, len_pv
    mov ecx, pv
    mov ebx, 1
    mov eax, 4
    int 0x80

    dec dword [player + Player.inventaire + Inventaire.potion + Potion.quantity]

    jmp _player_choice

_cant_use_heal_potion:
    ;Afficher que le joueur ne peux pas utiliser de potion
    mov edx, len_print_cant_use_potion
    mov ecx, print_cant_use_potion
    mov ebx, 1
    mov eax, 4
    int 0x80
    
    jmp _player_choice

_verify_use_heal_potion:
    ;Verifier si le joueur a au moins une potion pour pouvoir l'utiliser
    mov eax, [player + Player.inventaire + Inventaire.potion + Potion.quantity]

    cmp eax, 0
    jle _cant_use_heal_potion

    ;Verifier si le joueur a asser peux de pv por utiliser une potion
    mov eax, [player + Player.pv]
    add eax, [player + Player.inventaire + Inventaire.potion + Potion.heal]

    cmp eax, [player + Player.pv_max]
    jle _use_heal_potion
    cmp eax, [player + Player.pv_max]
    jg _cant_use_heal_potion

_end:
    mov eax, 1
    xor ebx, ebx
    int 0x80

section .bss
    player_name resb 50
    len_player_name resd 1
    what_player_choice resd 1
    attack_buffer resb 2
    pv_buffer resb 2
    level_buffer resb 2
    xp_buffer resb 2
    potion_buffer resb 2

section .data
;Créer le joueur
player:
    istruc Player
        at Player.name, times 50 db 0
        at Player.pv, dd 100
        at Player.pv_max, dd 100
        at Player.level, dd 1
        at Player.xp, dd 1
        at Player.level_up, dd 100
        at Player.attack, dd 10
        at Player.inventaire
        at Player.inventaire + Inventaire.potion + Potion.name, db 'Potion de soin'
        at Player.inventaire + Inventaire.potion + Potion.heal, dd 10
        at Player.inventaire + Inventaire.potion + Potion.quantity, dd 5
    iend

;Créer un monstre
goblin:
    istruc Monster
        at Monster.name, db "Goblin"
        at Monster.pv, dd 30
        at Monster.pv_max, dd 30
        at Monster.xp_min, dd 25
        at Monster.xp_max, dd 40
        at Monster.attack, dd 5
    iend

squelette:
    istruc Monster
        at Monster.name, db "Squelette"
        at Monster.pv, dd 50
        at Monster.pv_max, dd 50
        at Monster.xp_min, dd 70
        at Monster.xp_max, dd 100
        at Monster.attack, dd 8
    iend

    ;Dire ou est le joueur
    nb_salles dd 1


    ask_name db 'Bonjour, quelle est vottre nom ? '
    len_ask_name equ $ - ask_name

    print_player_name db 0xa, 'Bonjours '
    len_print_player_name equ $ - print_player_name

    print_salles_1 db ' vous arivez dans la Caverne des Goblin.', 0xa
    len_print_salles_1 equ $ - print_salles_1

    print_salles_2 db ' vous arivez dans la Crypte des Squelettes', 0xa
    len_print_salles_2 equ $ - print_salles_2

    un db 'Un '
    len_un equ $ - un

    goblin_name db 'Goblin'
    len_goblin_name equ $ - goblin_name

    squelette_name db 'Squelette '
    len_squelette_name equ $ - squelette_name

    attack_message db ' vous attaque', 0xa
    len_attack_message equ $ - attack_message

    what_player_choice_message:
        db 0xa
        db 'Que voulez vous faire ?'
        db 0xa
        db '1) Attaquer', 0xa
        db '2) Voir ses statistique', 0xa
        db '3) Voir ses potions', 0xa
        db '4) Utiliser une potion', 0xa
    len_what_player_choice_message equ $ - what_player_choice_message

    testt db 'test'
    len_test equ $ - testt
    
    player_attack db 'Vous avez infliger '
    len_player_attack equ $ - player_attack

    degat db ' dégat', 0xa
    len_degat equ $ - degat

    monster_die db 'Vous avez battue le '
    len_monster_die equ $ - monster_die

    player_pv db 0xa, 'Vous avez '
    len_player_pv equ $ - player_pv

    print_slash db '/'
    len_print_slash equ $ - print_slash

    pv db ' Pv', 0xa
    len_pv equ $ - pv

    le db 'Le '
    len_le equ $ - le

    a db ' a '
    len_a equ $ - a

    statistique db 0xa, 0xa, '========= Statistique =========', 0xa
    len_statistique equ $ - statistique

    print_player_name_stat db 0xa, 'Vottre Nom : '
    len_print_player_name_stat equ $ - print_player_name_stat

    print_player_level db 0xa, 'Niveaux : '
    len_print_player_level equ $ - print_player_level

    print_xp_player db 0xa, 'Xp : '
    len_print_xp_player equ $ - print_xp_player

    print_attack_player db 0xa, 'Attaque : '
    len_print_attack_player equ $ - print_attack_player

    print_player_pv db 0xa, 'Point de vie : '
    len_print_player_pv equ $ - print_player_pv

    newline db 0xa
    double_newline db 0xa, 0xa

    show_potions db 0xa, 0xa, '========= Potions =========', 0xa
    len_show_potions equ $ - show_potions

    potion db 0xa, 'Potions '
    len_potion equ $ - potion

    double_point db ' : '
    len_double_point equ $ - double_point

    potion_heal_1 db '(+'
    len_potion_heal_1 equ $ - potion_heal_1

    potion_heal_2 db ' Pv)'
    len_potion_heal_2 equ $ - potion_heal_2
    
    print_potion_used db 'Vous avez bien utiliser vottre potion', 0xa
    len_print_potion_used equ $ - print_potion_used

    print_cant_use_potion db 'Vous ne pouvez pas utiliser cette potion', 0xa
    len_print_cant_use_potion equ $ - print_cant_use_potion