GDPC                p                                                                         P   res://.godot/exported/133200997/export-3070c538c03ee49b7677ff960a3f5195-main.scn�      �      '��魡~|Ҙe�դ��    `   res://.godot/exported/133200997/export-b77f9875c13193b3a3188a9831caacdd-character_body_3d.scn   0      �      �jW�`��M��*�{an    ,   res://.godot/global_script_class_cache.cfg   9             ��Р�8���8~$}P�    D   res://.godot/imported/icon.svg-218a8f2b3041327d8a5756f3a245f83b.ctex 
      �      �̛�*$q�*�́        res://.godot/uid_cache.bin   =      a       �K ��R��
O�%�
       res://CharacterBody2D.gd�2      �      �5�ݵ������	��       res://character_body_3d.gd          $      G�0���}���W��    $   res://character_body_3d.tscn.remap  @8      n       z\I�˥eS;,�V�L8       res://icon.svg  @9      �      C��=U���^Qu��U3       res://icon.svg.import   �      �       ��n+ɹx�|�s���n       res://main.gd   �7      �       ZG^t�r5�i t7�e       res://main.tscn.remap   �8      a       �J�Sw� ������       res://project.binaryp=      �      HL6�Hn�q"��hc$i                extends CharacterBody3D

@export var speed = 14

@export var base_dmg = 1

const SPEED = 14.0
const JUMP_VELOCITY = 4.5

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

var target_velocity = Vector3.ZERO

		
func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()
	
	
            RSRC                    PackedScene            ��������                                                  resource_local_to_scene    resource_name    custom_solver_bias    margin    radius    height    script    lightmap_size_hint 	   material    custom_aabb    flip_faces    add_uv2    uv2_padding    radial_segments    rings    left_to_right    size    subdivide_width    subdivide_height    subdivide_depth 	   _bundled       Script    res://character_body_3d.gd ��������      local://CapsuleShape3D_0mym6 �         local://CapsuleMesh_kfkv1 �         local://PrismMesh_ednr4 �         local://PackedScene_pfjjd �         CapsuleShape3D             CapsuleMesh          
   PrismMesh             ?  �?   ?         PackedScene          	         names "         CharacterBody3D 
   transform    script    CollisionShape3D    shape    MeshInstance3D    mesh    MeshInstance3D2    	   variants            �?              �?              �?      �?                                      �?            1�;�  �?      ��1�;�    ���> )¾               node_count             nodes     (   ��������        ����                                  ����                           ����                           ����                         conn_count              conns               node_paths              editable_instances              version             RSRC              GST2   �   �      ����               � �        �  RIFF�  WEBPVP8L�  /������!"2�H�$�n윦���z�x����դ�<����q����F��Z��?&,
ScI_L �;����In#Y��0�p~��Z��m[��N����R,��#"� )���d��mG�������ڶ�$�ʹ���۶�=���mϬm۶mc�9��z��T��7�m+�}�����v��ح�m�m������$$P�����එ#���=�]��SnA�VhE��*JG�
&����^x��&�+���2ε�L2�@��		��S�2A�/E���d"?���Dh�+Z�@:�Gk�FbWd�\�C�Ӷg�g�k��Vo��<c{��4�;M�,5��ٜ2�Ζ�yO�S����qZ0��s���r?I��ѷE{�4�Ζ�i� xK�U��F�Z�y�SL�)���旵�V[�-�1Z�-�1���z�Q�>�tH�0��:[RGň6�=KVv�X�6�L;�N\���J���/0u���_��U��]���ǫ)�9��������!�&�?W�VfY�2���༏��2kSi����1!��z+�F�j=�R�O�{�
ۇ�P-�������\����y;�[ ���lm�F2K�ޱ|��S��d)é�r�BTZ)e�� ��֩A�2�����X�X'�e1߬���p��-�-f�E�ˊU	^�����T�ZT�m�*a|	׫�:V���G�r+�/�T��@U�N׼�h�+	*�*sN1e�,e���nbJL<����"g=O��AL�WO!��߈Q���,ɉ'���lzJ���Q����t��9�F���A��g�B-����G�f|��x��5�'+��O��y��������F��2�����R�q�):VtI���/ʎ�UfěĲr'�g�g����5�t�ۛ�F���S�j1p�)�JD̻�ZR���Pq�r/jt�/sO�C�u����i�y�K�(Q��7őA�2���R�ͥ+lgzJ~��,eA��.���k�eQ�,l'Ɨ�2�,eaS��S�ԟe)��x��ood�d)����h��ZZ��`z�պ��;�Cr�rpi&��՜�Pf��+���:w��b�DUeZ��ڡ��iA>IN>���܋�b�O<�A���)�R�4��8+��k�Jpey��.���7ryc�!��M�a���v_��/�����'��t5`=��~	`�����p\�u����*>:|ٻ@�G�����wƝ�����K5�NZal������LH�]I'�^���+@q(�q2q+�g�}�o�����S߈:�R�݉C������?�1�.��
�ڈL�Fb%ħA ����Q���2�͍J]_�� A��Fb�����ݏ�4o��'2��F�  ڹ���W�L |����YK5�-�E�n�K�|�ɭvD=��p!V3gS��`�p|r�l	F�4�1{�V'&����|pj� ߫'ş�pdT�7`&�
�1g�����@D�˅ �x?)~83+	p �3W�w��j"�� '�J��CM�+ �Ĝ��"���4� ����nΟ	�0C���q'�&5.��z@�S1l5Z��]�~L�L"�"�VS��8w.����H�B|���K(�}
r%Vk$f�����8�ڹ���R�dϝx/@�_�k'�8���E���r��D���K�z3�^���Vw��ZEl%~�Vc���R� �Xk[�3��B��Ğ�Y��A`_��fa��D{������ @ ��dg�������Mƚ�R�`���s����>x=�����	`��s���H���/ū�R�U�g�r���/����n�;�SSup`�S��6��u���⟦;Z�AN3�|�oh�9f�Pg�����^��g�t����x��)Oq�Q�My55jF����t9����,�z�Z�����2��#�)���"�u���}'�*�>�����ǯ[����82һ�n���0�<v�ݑa}.+n��'����W:4TY�����P�ר���Cȫۿ�Ϗ��?����Ӣ�K�|y�@suyo�<�����{��x}~�����~�AN]�q�9ޝ�GG�����[�L}~�`�f%4�R!1�no���������v!�G����Qw��m���"F!9�vٿü�|j�����*��{Ew[Á��������u.+�<���awͮ�ӓ�Q �:�Vd�5*��p�ioaE��,�LjP��	a�/�˰!{g:���3`=`]�2��y`�"��N�N�p���� ��3�Z��䏔��9"�ʞ l�zP�G�ߙj��V�>���n�/��׷�G��[���\��T��Ͷh���ag?1��O��6{s{����!�1�Y�����91Qry��=����y=�ٮh;�����[�tDV5�chȃ��v�G ��T/'XX���~Q�7��+[�e��Ti@j��)��9��J�hJV�#�jk�A�1�^6���=<ԧg�B�*o�߯.��/�>W[M���I�o?V���s��|yu�xt��]�].��Yyx�w���`��C���pH��tu�w�J��#Ef�Y݆v�f5�e��8��=�٢�e��W��M9J�u�}]釧7k���:�o�����Ç����ս�r3W���7k���e�������ϛk��Ϳ�_��lu�۹�g�w��~�ߗ�/��ݩ�-�->�I�͒���A�	���ߥζ,�}�3�UbY?�Ӓ�7q�Db����>~8�]
� ^n׹�[�o���Z-�ǫ�N;U���E4=eȢ�vk��Z�Y�j���k�j1�/eȢK��J�9|�,UX65]W����lQ-�"`�C�.~8ek�{Xy���d��<��Gf�ō�E�Ӗ�T� �g��Y�*��.͊e��"�]�d������h��ڠ����c�qV�ǷN��6�z���kD�6�L;�N\���Y�����
�O�ʨ1*]a�SN�=	fH�JN�9%'�S<C:��:`�s��~��jKEU�#i����$�K�TQD���G0H�=�� �d�-Q�H�4�5��L�r?����}��B+��,Q�yO�H�jD�4d�����0*�]�	~�ӎ�.�"����%
��d$"5zxA:�U��H���H%jس{���kW��)�	8J��v�}�rK�F�@�t)FXu����G'.X�8�KH;���[             [remap]

importer="texture"
type="CompressedTexture2D"
uid="uid://boyhu5ujhe1rr"
path="res://.godot/imported/icon.svg-218a8f2b3041327d8a5756f3a245f83b.ctex"
metadata={
"vram_texture": false
}
                RSRC                    PackedScene            ��������                                            2      slider 	   position 	   elevetah    resource_local_to_scene    resource_name 	   friction    rough    bounce 
   absorbent    script    custom_solver_bias    size    lightmap_size_hint 	   material    custom_aabb    flip_faces    add_uv2    uv2_padding    subdivide_width    subdivide_depth    center_offset    orientation    length 
   loop_mode    step    tracks/0/type    tracks/0/imported    tracks/0/enabled    tracks/0/path    tracks/0/interp    tracks/0/loop_wrap    tracks/0/keys    tracks/1/type    tracks/1/imported    tracks/1/enabled    tracks/1/path    tracks/1/interp    tracks/1/loop_wrap    tracks/1/keys    _data    line_spacing    font 
   font_size    font_color    outline_size    outline_color    shadow_size    shadow_color    shadow_offset 	   _bundled       Script    res://main.gd ��������   Script    res://CharacterBody2D.gd ��������
   Texture2D    res://icon.svg k�����r/      local://PhysicsMaterial_0fw2y '         local://RectangleShape2D_h7oyq G         local://QuadMesh_ppv4k x         local://RectangleShape2D_o2lve �         local://RectangleShape2D_w5gyc �         local://QuadMesh_dkhxp          local://Animation_jnep1          local://Animation_ca00s �         local://AnimationLibrary_bvqpr          local://RectangleShape2D_2pnsx g         local://QuadMesh_2n31y �         local://LabelSettings_cgjej �         local://PackedScene_qcipo �         PhysicsMaterial    	         RectangleShape2D       
    �D  B	      	   QuadMesh       
    ��D   B	         RectangleShape2D       
      C   C	         RectangleShape2D       
    ��C  �A	      	   QuadMesh    	      
   Animation          o�:         value                                                                    times !                transitions !        �?      values       
     �C ��C      update                  value !          "         #              $         %         &               times !                transitions !        �?      values       
    �)D ��C      update        	      
   Animation             slide          @                  value                                                                    times !             @      transitions !        �?  �?      values       
     �C ��C
    @JD ��C      update                  value !          "         #              $         %         &               times !             @      transitions !        �?  �?      values       
    �)D ��C
    �)D �OD      update        	         AnimationLibrary    '               RESET                slide          	         RectangleShape2D       
     �D  �A	      	   QuadMesh    	         LabelSettings    	         PackedScene    1      	         names "   6      Node    script    Node2D 	   platform 	   position    physics_material_override    metadata/_edit_group_    StaticBody2D    CollisionShape2D1    shape    CollisionShape2D    MeshInstance2D    scale    mesh    wall    CollisionShape2D3 	   rotation    cosetti    MeshInstance2D2    MeshInstance2D3    MeshInstance2D4    MeshInstance2D5    MeshInstance2D6    MeshInstance2D7    MeshInstance2D8    MeshInstance2D9    MeshInstance2D10    MeshInstance2D11    MeshInstance2D12    MeshInstance2D13    Player    CharacterBody2D 	   Sprite2D    texture    CollisionShape2D4 	   Camera2D    slider    AnimatableBody2D    CollisionShape2D5 	   elevetah    AnimationPlayer 
   libraries    CanvasLayer    follow_viewport_enabled    Label    clip_contents    offset_left    offset_top    offset_right    offset_bottom    text    label_settings    Label2    Label3    	   variants    =             
     �@  ��                
     �C ��C         
    `�C  �C
   ���>  �?         
     �B  CC   ��?
     �D   �
    ���  �C
   8I�=  �?
     ��  �C
     ��  �C
     XB  �C
     XC  �C
     �C  �C
     	D ��C
    �1D ��C
    @ZD ��C
     �D ��C
    @�D ��C
    �D ��C
    ��D ��C
     �B ��C         
      @  �?         
     @@             
     �C ��C
     C  0A         
    ��C  �A         
    �)D ��C                      
     �D  �C
     }D  0A      	   
    �|D  ,A
    �D  �A      
        �A     OC     �B     �C      <- : move left
-> : move right               �C     gC    �D    ��C      space: jump     ��D    ��C    ��D    ��C      shift: jump       node_count    '         nodes     �  ��������       ����                            ����                                
      ����         	                       ����                                       ����      	                          
      ����            
   	                       ����            
                                 ����                                ����                                      ����                                      ����                                      ����                                      ����                                      ����                                      ����                                      ����                                      ����                                      ����                                      ����                                      ����                                      ����                                       ����                                        ����         !                 
   "   ����         	                 #   #   ����                %   $   ����                           
   &   ����      !   	   "                    ����      !      #      $               %   '   ����      %                    
   
   ����      !   	   "                    ����      !      #      $               (   (   ����   )   &                     ����      '                     
   
   ����      (   	   )                     ����      *      +      ,               *   *   ����   +          #       ,   ,   ����   -      .   -   /   .   0   /   1   0   2   1   3   2       #       ,   4   ����   .   3   /   4   0   5   1   6   2   7       #       ,   5   ����   .   8   /   9   0   :   1   ;   2   <             conn_count              conns               node_paths              editable_instances              version       	      RSRC             extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -600.0
const SLIDE_SPEED = 500.0
const GO_DOWN = 1000.0
const DASH_DURATION = 0.5

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var tween: Tween
var dash_velocity := 0.0

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		
	if(Input.is_action_just_pressed("ui_down") and not is_on_floor()):
		velocity.y = GO_DOWN

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("ui_left", "ui_right")
	
	if Input.is_action_just_pressed("dash"):
		dash_velocity = SLIDE_SPEED
		rotate(deg_to_rad(90))
		if tween:
			tween.stop()
			rotate(deg_to_rad(0))
		tween = create_tween()
		tween.tween_property(self, "dash_velocity", 0, 0.3).set_ease(Tween.EASE_OUT)
	
	if direction:
		velocity.x = direction * (SPEED + dash_velocity)
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	

	move_and_slide()
    extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimationPlayer.play("slide")
	$AnimationPlayer.play("elevetah")

           [remap]

path="res://.godot/exported/133200997/export-b77f9875c13193b3a3188a9831caacdd-character_body_3d.scn"
  [remap]

path="res://.godot/exported/133200997/export-3070c538c03ee49b7677ff960a3f5195-main.scn"
               list=Array[Dictionary]([])
     <svg height="128" width="128" xmlns="http://www.w3.org/2000/svg"><rect x="2" y="2" width="124" height="124" rx="14" fill="#363d52" stroke="#212532" stroke-width="4"/><g transform="scale(.101) translate(122 122)"><g fill="#fff"><path d="M105 673v33q407 354 814 0v-33z"/><path fill="#478cbf" d="m105 673 152 14q12 1 15 14l4 67 132 10 8-61q2-11 15-15h162q13 4 15 15l8 61 132-10 4-67q3-13 15-14l152-14V427q30-39 56-81-35-59-83-108-43 20-82 47-40-37-88-64 7-51 8-102-59-28-123-42-26 43-46 89-49-7-98 0-20-46-46-89-64 14-123 42 1 51 8 102-48 27-88 64-39-27-82-47-48 49-83 108 26 42 56 81zm0 33v39c0 276 813 276 813 0v-39l-134 12-5 69q-2 10-14 13l-162 11q-12 0-16-11l-10-65H447l-10 65q-4 11-16 11l-162-11q-12-3-14-13l-5-69z"/><path d="M483 600c3 34 55 34 58 0v-86c-3-34-55-34-58 0z"/><circle cx="725" cy="526" r="90"/><circle cx="299" cy="526" r="90"/></g><g fill="#414042"><circle cx="307" cy="532" r="60"/><circle cx="717" cy="532" r="60"/></g></g></svg>
             O-۴fw   res://character_body_3d.tscnk�����r/   res://icon.svgVw���y   res://main.tscn               ECFG
      application/config/name         Project D.I.A.M.   application/run/main_scene         res://main.tscn    application/config/features$   "         4.2    Forward Plus       application/config/icon         res://icon.svg     input/move_up�              deadzone      ?      events              InputEventKey         resource_local_to_scene           resource_name             device     ����	   window_id             alt_pressed           shift_pressed             ctrl_pressed          meta_pressed          pressed           keycode           physical_keycode   W   	   key_label             unicode    w      echo          script            InputEventKey         resource_local_to_scene           resource_name             device     ����	   window_id             alt_pressed           shift_pressed             ctrl_pressed          meta_pressed          pressed           keycode           physical_keycode    @ 	   key_label             unicode           echo          script            InputEventJoypadMotion        resource_local_to_scene           resource_name             device     ����   axis      
   axis_value       ��   script         input/move_left�              deadzone      ?      events              InputEventKey         resource_local_to_scene           resource_name             device     ����	   window_id             alt_pressed           shift_pressed             ctrl_pressed          meta_pressed          pressed           keycode           physical_keycode   A   	   key_label             unicode    a      echo          script            InputEventKey         resource_local_to_scene           resource_name             device     ����	   window_id             alt_pressed           shift_pressed             ctrl_pressed          meta_pressed          pressed           keycode           physical_keycode    @ 	   key_label             unicode           echo          script            InputEventJoypadMotion        resource_local_to_scene           resource_name             device     ����   axis       
   axis_value       ��   script         input/move_down�              deadzone      ?      events              InputEventKey         resource_local_to_scene           resource_name             device     ����	   window_id             alt_pressed           shift_pressed             ctrl_pressed          meta_pressed          pressed           keycode           physical_keycode   S   	   key_label             unicode    s      echo          script            InputEventKey         resource_local_to_scene           resource_name             device     ����	   window_id             alt_pressed           shift_pressed             ctrl_pressed          meta_pressed          pressed           keycode           physical_keycode    @ 	   key_label             unicode           echo          script            InputEventJoypadMotion        resource_local_to_scene           resource_name             device     ����   axis      
   axis_value       �?   script         input/move_right�              deadzone      ?      events              InputEventKey         resource_local_to_scene           resource_name             device     ����	   window_id             alt_pressed           shift_pressed             ctrl_pressed          meta_pressed          pressed           keycode           physical_keycode   D   	   key_label             unicode    d      echo          script            InputEventKey         resource_local_to_scene           resource_name             device     ����	   window_id             alt_pressed           shift_pressed             ctrl_pressed          meta_pressed          pressed           keycode           physical_keycode    @ 	   key_label             unicode           echo          script            InputEventJoypadMotion        resource_local_to_scene           resource_name             device     ����   axis       
   axis_value       �?   script         input/attack<              deadzone      ?      events              InputEventMouseButton         resource_local_to_scene           resource_name             device     ����	   window_id             alt_pressed           shift_pressed             ctrl_pressed          meta_pressed          button_mask          position     OC  pA   global_position      SC  `B   factor       �?   button_index         canceled          pressed          double_click          script            InputEventKey         resource_local_to_scene           resource_name             device     ����	   window_id             alt_pressed           shift_pressed             ctrl_pressed          meta_pressed          pressed           keycode           physical_keycode       	   key_label             unicode           echo          script            InputEventJoypadButton        resource_local_to_scene           resource_name             device     ����   button_index         pressure          pressed          script      
   input/dash�              events              InputEventKey         resource_local_to_scene           resource_name             device     ����	   window_id             alt_pressed           shift_pressed             ctrl_pressed          meta_pressed          pressed           keycode           physical_keycode    @ 	   key_label             unicode           echo          script            deadzone      ?        