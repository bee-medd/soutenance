# create_robe.py
import trimesh
import numpy as np

# إنشاء جسم الروب (مكعب ممدود)
robe_height = 1.2
robe_width = 0.6
robe_depth = 0.4

# الجسم الرئيسي
body = trimesh.creation.box(extents=[robe_width, robe_height, robe_depth])

# إضافة الوشاح (شريط على الكتف)
stole = trimesh.creation.box(extents=[0.15, 0.8, 0.05])
stole.apply_translation([0.3, 0.3, 0.1])

# إضافة ياقة V
collar_left = trimesh.creation.box(extents=[0.1, 0.15, 0.1])
collar_left.apply_translation([-0.2, 0.55, 0.2])
collar_right = trimesh.creation.box(extents=[0.1, 0.15, 0.1])
collar_right.apply_translation([0.2, 0.55, 0.2])

# دمج جميع الأجزاء
robe = trimesh.util.concatenate([body, stole, collar_left, collar_right])

# تصدير كـ GLB
robe.export('assets/models/robe.glb')
print("✅ تم إنشاء robe.glb في مجلد assets/models/")
