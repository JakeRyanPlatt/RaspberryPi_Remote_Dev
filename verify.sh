#!/bin/bash

# Pre-Commit Verification Checklist
# Run this before committing to GitHub

echo "========================================="
echo "  Pre-Commit Verification Checklist"
echo "========================================="
echo ""

# Color codes
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

ERRORS=0
WARNINGS=0

# Check 1: Verify images directory exists
echo "1. Checking images directory..."
if [ -d "images" ]; then
  echo -e "${GREEN}✓${NC} images/ directory exists"
else
  echo -e "${RED}✗${NC} images/ directory NOT found"
  ERRORS=$((ERRORS + 1))
fi
echo ""

# Check 2: List and verify image files
echo "2. Checking for required image files..."
REQUIRED_IMAGES=(
  "question.png"
  "question2Results.png"
  "question4Results.png"
  "question5Results.png"
  "question6Results.png"
  "question7Results.png"
  "question8Results.png"
)

for img in "${REQUIRED_IMAGES[@]}"; do
  if [ -f "images/$img" ]; then
    echo -e "${GREEN}✓${NC} images/$img exists"
  else
    echo -e "${RED}✗${NC} images/$img MISSING"
    ERRORS=$((ERRORS + 1))
  fi
done
echo ""

# Check 3: Verify markdown file exists
echo "3. Checking for markdown document..."
if [ -f "memo-corrected.md" ] || [ -f "procedure.md" ]; then
  echo -e "${GREEN}✓${NC} Markdown document found"
else
  echo -e "${RED}✗${NC} No markdown document found"
  ERRORS=$((ERRORS + 1))
fi
echo ""

# Check 4: Check for broken image links in markdown
echo "4. Scanning for broken image syntax..."
if [ -f "memo-corrected.md" ]; then
  DOC="memo-corrected.md"
elif [ -f "procedure.md" ]; then
  DOC="procedure.md"
else
  echo -e "${YELLOW}⚠${NC} No document to scan"
  WARNINGS=$((WARNINGS + 1))
  DOC=""
fi

if [ -n "$DOC" ]; then
  # Check for double parentheses (broken syntax)
  if grep -q "!()" "$DOC"; then
    echo -e "${RED}✗${NC} Found broken image syntax: !()"
    echo "   Please fix to: ![Description](./images/file.png)"
    ERRORS=$((ERRORS + 1))
  else
    echo -e "${GREEN}✓${NC} No broken !() syntax found"
  fi

  # Check for missing image descriptions
  if grep -q "!\[\](" "$DOC"; then
    echo -e "${YELLOW}⚠${NC} Found empty image descriptions: ![]("
    echo "   Consider adding: ![Descriptive text](./images/file.png)"
    WARNINGS=$((WARNINGS + 1))
  else
    echo -e "${GREEN}✓${NC} All images have descriptions"
  fi

  # Check for absolute paths
  if grep -q "!\[.*\](/.*\.png\|C:.*\.png\|/Users.*\.png" "$DOC"; then
    echo -e "${RED}✗${NC} Found absolute paths in image links"
    echo "   Use relative paths: ./images/file.png"
    ERRORS=$((ERRORS + 1))
  else
    echo -e "${GREEN}✓${NC} All image paths are relative"
  fi
fi
echo ""

# Check 5: Git status
echo "5. Checking Git status..."
if git rev-parse --git-dir >/dev/null 2>&1; then
  echo -e "${GREEN}✓${NC} Git repository initialized"

  # Check if there are uncommitted changes
  if [[ -n $(git status -s) ]]; then
    echo -e "${YELLOW}⚠${NC} Uncommitted changes found:"
    git status -s
  else
    echo -e "${GREEN}✓${NC} No uncommitted changes"
  fi
else
  echo -e "${RED}✗${NC} Not a Git repository"
  echo "   Run: git init"
  ERRORS=$((ERRORS + 1))
fi
echo ""

# Check 6: .gitignore exists
echo "6. Checking for .gitignore..."
if [ -f ".gitignore" ]; then
  echo -e "${GREEN}✓${NC} .gitignore exists"
  if grep -q ".obsidian" ".gitignore"; then
    echo -e "${GREEN}✓${NC} .gitignore includes .obsidian/"
  else
    echo -e "${YELLOW}⚠${NC} .gitignore missing .obsidian/"
    WARNINGS=$((WARNINGS + 1))
  fi
else
  echo -e "${YELLOW}⚠${NC} .gitignore not found (recommended)"
  WARNINGS=$((WARNINGS + 1))
fi
echo ""

# Check 7: README exists
echo "7. Checking for README..."
if [ -f "README.md" ]; then
  echo -e "${GREEN}✓${NC} README.md exists"
else
  echo -e "${YELLOW}⚠${NC} README.md not found (recommended for GitHub)"
  WARNINGS=$((WARNINGS + 1))
fi
echo ""

# Summary
echo "========================================="
echo "  Summary"
echo "========================================="
if [ $ERRORS -eq 0 ] && [ $WARNINGS -eq 0 ]; then
  echo -e "${GREEN}✓ ALL CHECKS PASSED!${NC}"
  echo ""
  echo "You're ready to commit! Run:"
  echo "  git add ."
  echo "  git commit -m 'Add audience analysis memo with survey results'"
  echo "  git push"
elif [ $ERRORS -eq 0 ]; then
  echo -e "${YELLOW}⚠ $WARNINGS WARNING(S)${NC}"
  echo ""
  echo "You can commit, but consider addressing warnings first."
else
  echo -e "${RED}✗ $ERRORS ERROR(S) FOUND${NC}"
  if [ $WARNINGS -gt 0 ]; then
    echo -e "${YELLOW}⚠ $WARNINGS WARNING(S)${NC}"
  fi
  echo ""
  echo "Fix errors before committing to GitHub."
fi
echo "========================================="
