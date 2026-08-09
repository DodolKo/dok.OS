# 🖥️ dokOS - Bare-Metal Operating System from Scratch

**dokOS** est un projet d'apprentissage de création d'un système d'exploitation x86 à partir de zéro (*bare-metal*).

L'environnement de développement repose sur **Docker** uniquement en tant que container de compilation (toolchain isolée) couplé à **QEMU** pour tester l'OS sans toucher à l'hôte.

---

## 🛠️ Structure du Projet

```text
.
├── Dockerfile        # Environnement de compilation minimal (GCC 32-bit, NASM, QEMU, Linker)
├── Makefile          # Script d'assemblage, de compilation C et d'édition de liens
├── linker.ld         # Script du Linker pour ordonner la mémoire physique (Multiboot 1MB)
├── boot.asm          # En-tête Multiboot 1 + Bootstrap Assembly 32-bit (Ring 0)
├── kernel.c          # Point d'entrée du Noyau en C (Écriture directe en mémoire vidéo VGA 0xB8000)
├── .gitignore        # Fichiers ignorés par Git (objets .o, binaires .elf, images ISO)
└── README.md         # Documentation du projet
```

---

## 🚀 Prise en main rapide

### 1. Construire l'image Docker de compilation
```bash
docker build -t dokos-env .
```

### 2. Compiler le Noyau (`kernel.elf`)
Exécute la compilation au sein du conteneur sans rien installer sur ton système :
```bash
docker run --rm -v $(pwd):/workspace dokos-env make
```

### 3. Tester le Noyau avec QEMU

* **Option A (Terminal text/nographic dans Docker) :**
```bash
docker run --rm -v $(pwd):/workspace dokos-env make qemu
```
*(Pour quitter QEMU en mode nographic : presse `Ctrl + A` puis `X`)*

* **Option B (Si QEMU est installé sur ton Mac pour l'interface graphique) :**
```bash
qemu-system-i386 -kernel kernel.elf
```

---

## 🎯 Prochaines étapes de développement OS

1. **VGA Driver & Terminal :** Gérer le défilement du texte (*scrolling*), le curseur, la couleur des caractères et les retours à la ligne `\n`.
2. **GDT (Global Descriptor Table) :** Définir les segments de mémoire pour séparer le mode Kernel et le mode User.
3. **IDT (Interrupt Descriptor Table) & ISR :** Gérer les interruptions système et intercepter le clavier (IRQ 1).
4. **Gestion de la Mémoire :** Implémenter un allocateur physique (PMM) puis la pagination (VMM).
