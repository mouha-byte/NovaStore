import re

# Read the file
with open('lib/screens/single_product_landing.dart', 'r', encoding='utf-8') as f:
    content = f.read()

# Comment out flutter_animate import
content = content.replace(
    "import 'package:flutter_animate/flutter_animate.dart';",
    "// import 'package:flutter_animate/flutter_animate.dart'; // DISABLED FOR PERFORMANCE"
)

# Remove all animation patterns - more aggressive approach
# This will handle nested parentheses better

# Step 1: Remove .animate(onPlay: (controller) => controller.repeat()) and similar
content = re.sub(r'\.animate\(onPlay:\s*\([^)]*\)\s*=>\s*[^)]*\.[^)]*\([^)]*\)\)', '', content)

# Step 2: Remove .animate(onPlay: (controller) => controller.repeat(reverse: true))
content = re.sub(r'\.animate\(onPlay:\s*\([^)]*\)\s*=>\s*[^)]*\.[^)]*\([^)]*\)\)', '', content)

# Step 3: Remove simple .animate()
content = re.sub(r'\.animate\(\)', '', content)

# Step 4: Remove all chained animation methods
animation_methods = ['fadeIn', 'fadeOut', 'slideX', 'slideY', 'scale', 'shimmer', 'custom']
for method in animation_methods:
    # Handle method calls with various parameter patterns
    content = re.sub(rf'\.{method}\([^)]*\)', '', content)

# Step 5: Clean up any remaining double dots
content = re.sub(r'\.\.', '.', content)

# Step 6: Clean up trailing commas with dots  
content = re.sub(r',\s*\n\s*\.', ',', content)

# Write back
with open('lib/screens/single_product_landing.dart', 'w', encoding='utf-8') as f:
    f.write(content)

print("✅ All animations removed successfully!")
print("✅ flutter_animate import commented out")
print("✅ Animation methods removed: " + ", ".join(animation_methods))
