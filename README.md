# 🖥️ dokOS - Bare-Metal Operating System from Scratch

**dokOS** est un projet d'apprentissage de création d'un système d'exploitation x86 à partir de zéro (*bare-metal*).

L'environnement de développement repose sur **Docker** uniquement en tant que container de compilation (toolchain isolée) couplé à **QEMU** pour tester l'OS sans toucher à l'hôte.

---

## 🛠️ Structure du Projet

```text
.
├── Dockerfile        # Environnement de compilation (Rust nightly target i686, NASM, QEMU, Linker)
├── Makefile          # Script d'assemblage (boot.asm), compilation Rust (kernel.rs) et d'édition de liens
├── linker.ld         # Script du Linker pour ordonner la mémoire physique (Multiboot 1MB)
├── boot.asm          # En-tête Multiboot 1 + Bootstrap Assembly 32-bit (Ring 0)
├── kernel.rs         # Point d'entrée du Noyau en Rust #![no_std] (Écriture directe en mémoire VGA 0xB8000)
├── build.sh          # Script de build automatique
├── run.sh            # Script d'exécution automatique via QEMU
├── .gitignore        # Fichiers ignorés par Git
└── README.md         # Documentation du projet
```

---

## 🚀 Prise en main rapide (Une seule commande !)

Toute personne ayant **Docker** installé peut directement utiliser les scripts d'automatisation :

### 1. Recompiler l'OS
```bash
./build.sh
```
*Construit l'image Docker si nécessaire et compile `kernel.elf`.*

### 2. Lancer l'OS dans le terminal
```bash
./run.sh
```
*Compile si besoin et lance l'émulateur QEMU directement dans ton terminal.*
*(Pour quitter QEMU : presse `Ctrl + A` puis `X`)*

---

## 🛠️ Exécution manuelle via Docker

Si tu préfères exécuter les étapes manuellement :

```bash
# 1. Construire l'image
docker build -t dokos-env .

# 2. Compiler
docker run --rm -v $(pwd):/workspace dokos-env make

# 3. Lancer dans QEMU
docker run --rm -it -v $(pwd):/workspace dokos-env make qemu
```

---

## 🎯 Prochaines étapes de développement OS

1. **VGA Driver & Terminal :** Gérer le défilement du texte (*scrolling*), le curseur, la couleur des caractères et les retours à la ligne `\n`.
2. **GDT (Global Descriptor Table) :** Définir les segments de mémoire pour séparer le mode Kernel et le mode User.
3. **IDT (Interrupt Descriptor Table) & ISR :** Gérer les interruptions système et intercepter le clavier (IRQ 1).
4. **Gestion de la Mémoire :** Implémenter un allocateur physique (PMM) puis la pagination (VMM).
