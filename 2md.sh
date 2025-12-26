output="esp32_project_context.md"

# 1. 寫入標題與目錄結構 (排除被忽略的資料夾)
echo "# ESP32 Project Structure & Source Code" > $output
echo "## Folder Structure" >> $output
echo '```' >> $output
# 使用 tree 指令 (若無 tree 則改用 find)
tree -L 3 -I "managed_components|images|fonts|models" >> $output
echo '```' >> $output
echo -e "\n---\n" >> $output

# 2. 遍歷並合併核心程式碼 (主要抓取 main 和 components)
# 排除 .png, .jpg, .espdl, .a, .json 以及 managed_components 資料夾
find . -type f \( -name "*.c" -o -name "*.cpp" -o -name "*.h" -o -name "*.hpp" -o -name "*.txt" \) \
-not -path "*/managed_components/*" \
-not -path "*/images/*" \
-not -path "*/fonts/*" \
-not -path "*/models/*" | while read file; do
    echo "## File: $file" >> $output
    echo '```cpp' >> $output
    cat "$file" >> $output
    echo -e "\n" >> $output
    echo '```' >> $output
    echo -e "\n---\n" >> $output
done

echo "完成！檔案已儲存為 $output"
